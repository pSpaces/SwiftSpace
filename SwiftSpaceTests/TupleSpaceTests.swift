//
//  TupleSpaceTests.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 06/05/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import XCTest

class TupleSpaceTests: XCTestCase {
    var ts = TupleSpace(TupleTree())
    //var ts = TupleSpace(TupleList())
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        //Inserimento
        let tupla1 = [1, 5]
        let tupla2 = [1, false] as [TupleField]
        let tupla3 = [false, true]
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla2))
        XCTAssert(ts.put(tupla3))
        
        //Test Contenuto
        var tuples = ts.queryAll()
        XCTAssert(self.compareAny(tuples[0], tupla1))
        XCTAssert(self.compareAny(tuples[1], tupla2))
        XCTAssert(self.compareAny(tuples[2], tupla3))
        
        //Test Template Attuale
        var template : [TemplateField] = [1,5]
        XCTAssert(self.compareAny(tupla1, ts.queryp(template)))
        
        template = [1,false]
        XCTAssert(self.compareAny(tupla2, ts.queryp(template)))
        
        //Test Template Formale
        template = [FormalTemplateField(Int.self),FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny(tupla2, ts.queryp(template)))
        
        template = [FormalTemplateField(Bool.self),FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny(tupla3, ts.queryp(template)))
        
        //Test Template Attuale e Formale
        template = [false,FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny(tupla3, ts.queryp(template)))
        
        //Test Template Attuale e Formale Non Esistente
        template = [true,FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny([], ts.queryp(template)))
        
        let t11 = [1]
        let t111 = [1,1,1]
        
        XCTAssert(true == ts.put(t11))
        XCTAssert(true == ts.put(t111))
        
        let tupla0 = [5,5]
        XCTAssert(true == ts.put(tupla0))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Int.self)]
        let res = ts.queryAll(template)
        XCTAssert(self.compareAny(tupla1, res[0]))
        XCTAssert(self.compareAny(tupla0, res[1]))
        XCTAssert(2 == res.count)
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny(tupla2, ts.queryp(template)))
        
        XCTAssert(self.compareAny(tupla2, ts.getp([(1), (false)])))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny([], ts.queryp(template)))
        
        template = [1]
        XCTAssert(self.compareAny(t11, ts.get(template)))
        template = [1, 1, 1]
        XCTAssert(self.compareAny(t111, ts.getp(template)))
        
        XCTAssert(self.compareAny(tupla1, ts.getp([(1), (5)])))
        XCTAssert(self.compareAny(tupla3, ts.getp([(false), (true)])))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny([], ts.queryp(template)))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Int.self)]
        XCTAssert(self.compareAny(tupla0, ts.queryp(template)))
        
        XCTAssert(self.compareAny(tupla0, ts.getp([FormalTemplateField(Int.self),FormalTemplateField(Int.self)])))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Int.self)]
        XCTAssert(self.compareAny([], ts.queryp(template)))
        
        template = [FormalTemplateField(Bool.self),FormalTemplateField(Bool.self)]
        XCTAssert(self.compareAny([], ts.queryp(template)))
        
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla1))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Int.self)]
        XCTAssert(ts.queryAll(template).count == 4)
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Int.self)]
        XCTAssert(ts.getAll(template).count == 4)
        
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla1))
        XCTAssert(ts.put(tupla1))
        
        print(ts.queryAll())
        
        XCTAssert(ts.queryAll().count == 4)
        XCTAssert(ts.getAll().count == 4)
        
        let p1 = [1,1,2,3]
        let p2 = [1,1,1,2]
        
        XCTAssert(ts.put(p1))
        XCTAssert(ts.put(p2))
        
        template = [FormalTemplateField(Int.self),FormalTemplateField(Int.self), FormalTemplateField(Int.self), 2]
        XCTAssert(self.compareAny(p2, ts.queryp(template)))
        
        XCTAssert(ts.getAll().count == 2)
        
        
        XCTAssert(ts.put(p1))
        XCTAssert(ts.put(p2))
        
        //TEST GET VUOTO
        //XCTAssert(self.compareAny([], ts.get([TemplateField]())))
        
        print(self.ts.queryAll().count)
        print("TEST CONCORRENZA")
        //TEST CONCORRENZA
        let queue = DispatchQueue.init(label: "it.SwiftSpace.TestThreads1", qos: .utility , attributes: .concurrent)

        queue.async {
            for i in 0...100 {
                 _ = self.ts.put([1,2,3])
                print("INSERITO \(i)")
            }
        }
        
        for i in 0...100 {
            _ = self.ts.get([1,2,3])
            print("TROVATO \(i)")
        }
        
        print("Fine")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let stress = 2499
        let maxLength = 5
        let difference = 10
        
        self.measure {
            for _ in 0...stress {
                _ = self.ts.put(self.generateRandomTuple(maxLength, difference))
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [(diceRoll1)]
                _ = self.ts.queryp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [(diceRoll1), (diceRoll2)]
                _ = self.ts.queryp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll3 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [(diceRoll1), (diceRoll2), (diceRoll3)]
                _ = self.ts.queryp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll3 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll4 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [(diceRoll1), (diceRoll2), (diceRoll3), (diceRoll4)]
                _ = self.ts.queryp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll3 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll4 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll5 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [(diceRoll1), (diceRoll2), (diceRoll3), (diceRoll4), (diceRoll5)]
                _ = self.ts.queryp(template)
            }
            
            for _ in 0...stress/5 {
                let template = [FormalTemplateField(Int.self)]
                _ = self.ts.queryp(template)
            }
            
            for _ in 0...9 {
                _ = self.ts.queryAll()
            }
            
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [diceRoll1]
                _ = self.ts.getp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [diceRoll1, diceRoll2]
                _ = self.ts.getp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll3 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [diceRoll1, diceRoll2, diceRoll3]
                _ = self.ts.getp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll3 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll4 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [diceRoll1, diceRoll2, diceRoll3, diceRoll4]
                _ = self.ts.getp(template)
            }
            for _ in 0...stress/5 {
                let diceRoll1 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll2 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll3 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll4 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let diceRoll5 = Int(arc4random_uniform(UInt32(difference)) + 1)
                let template = [(diceRoll1), (diceRoll2), (diceRoll3), (diceRoll4), (diceRoll5)]
                _ = self.ts.getp(template)
            }
            
            for _ in 0...stress/5 {
                let template = [FormalTemplateField(Int.self)]
                _ = self.ts.getp(template)
            }
            
            _ = self.ts.getAll()
        }
    }
    
    private func generateRandomTuple(_ maxLength : Int, _ difference : Int) -> [TupleField] {
        var tuple = [TupleField]()
        let length = Int(arc4random_uniform(UInt32(maxLength)) + 1)
        for _ in 0...length {
            let random = Int(arc4random_uniform(UInt32(difference)) + 1)
            tuple.append(random)
        }
        return tuple
    }
    
    func compareAny(_ a: TupleField,_ b: TupleField) -> Bool {
        if let va = a as? Int, let vb = b as? Int {
            return va == vb
        } else if let va = a as? Float, let vb = b as? Float {
            return va == vb
        } else if let va = a as? Double, let vb = b as? Double {
            return va == vb
        }else if let va = a as? String, let vb = b as? String {
            return va == vb
        } else if let va = a as? Bool, let vb = b as? Bool {
            return va == vb
        } else if let va = a as? Array<TupleField>, let vb = b as? Array<TupleField> {
            return self.compareArrayAny(va, vb)
        }else if let va = a as? Set<AnyHashable>, let vb = b as? Set<AnyHashable> {
            return va == vb
        } else if let va = a as? Dictionary<AnyHashable, TupleField>, let vb = b as? Dictionary<AnyHashable, TupleField> {
            return NSDictionary(dictionary: va).isEqual(to: vb)
        } else {
            return false;
        }
    }
    
    private func compareArrayAny(_ a : [TupleField],_ b : [TupleField]) -> Bool {
        if(a.count != b.count){
            return false
        }
        if(a.count != 0){
            for i in 0...a.count-1 {
                if !self.compareAny(a[i], b[i]) {
                    return false
                }
            }
        }
        return true
    }
    
}
