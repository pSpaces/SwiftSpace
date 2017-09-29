//
//  SpaceValueTests.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 16/05/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import XCTest

class SpaceValueTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //TESTARE TUTTE LE LUNGHEZZE DIVERSE!!!!
    func testExample() {
        //TEST INTERI
        let int1 = 5
        let int2 = 5
        let int3 = 6
        XCTAssert(int1.equals(int2))
        XCTAssert(int2.equals(int1))
        XCTAssert(!int1.equals(int3))
        
        //TEST FLOAT
        let float1 : Float = 5
        let float2 : Float = 5
        let float3 : Float = 5.5
        XCTAssert(float1.equals(float2))
        XCTAssert(float2.equals(float1))
        XCTAssert(!float1.equals(float3))
        
        //TEST DOUBLE
        let double1 : Double = 5
        let double2 : Double = 5
        let double3 : Double = 5.5
        XCTAssert(double1.equals(double2))
        XCTAssert(double2.equals(double1))
        XCTAssert(!double1.equals(double3))
        
        //TEST DIFFERENZA TIPI
        XCTAssert(!int1.equals(float1))
        XCTAssert(!int1.equals(double1))
        XCTAssert(!double1.equals(float1))
        
        //TEST STRING
        let string1 = "Test"
        let string2 = "Test"
        let string3 = "TEST"
        XCTAssert(string1.equals(string2))
        XCTAssert(!string1.equals(string3))
        
        //TEST BOOL
        let bool1 = true
        let bool2 = true
        let bool3 = false
        XCTAssert(bool1.equals(bool2))
        XCTAssert(!bool1.equals(bool3))
        
        //TEST ARRAY
        let array1 = [5,6]
        let array2 = [5,6]
        let array3 = [5,6,7,8]
        let array4 = [true,false]
        let array5 = [5.5,6]
        XCTAssert(array1.equals(array2))
        XCTAssert(!array1.equals(array3))
        XCTAssert(!array1.equals(array4))
        XCTAssert(!array1.equals(array5))
        
        
        //TEST DIZIONARI
        /*
         let dic1 : [String: SpaceValue] = ["key1": 100, "key2": 200]
         let dic2 : [String: SpaceValue] = ["key1": 100, "key2": 200]
         let dic3 : [String: SpaceValue] = ["key1": 100, "key2": true]
         let dic4 : [String: SpaceValue] = ["key1": 100.5 as Float, "key2": 200]
         let dic5 : [String: SpaceValue] = ["key1": 100.5 as Double, "key2": 200]
         XCTAssert(dic1.equals(dic2))
         XCTAssert(!dic1.equals(dic3))
         XCTAssert(!dic4.equals(dic5))
         */
        
        //TEST SET
        /*
         print("SET")
         
         var letters1 = Set<String>()
         letters1.insert("a")
         letters1.insert("b")
         var letters2 = Set<String>()
         letters2.insert("a")
         letters2.insert("b")
         var letters3 = Set<String>()
         letters3.insert("a")
         letters3.insert("c")
         print(letters1.equals(letters2))
         print(letters3.equals(letters2))*/
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
