//
//  Field.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 26/04/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

protocol TemplateField {
    func match(_ o : TupleField) -> Bool
}

protocol TupleField {
    func equals(_ sv : TupleField) -> Bool
}

extension Int : TemplateField, TupleField {

    func equals(_ sv : TupleField) -> Bool {
        if let int = sv as? Int {
            return self == int
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
    
}

extension Int64 : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let int = sv as? Int64 {
            return self == int
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
    
}

extension Byte : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let int = sv as? Byte {
            return self == int
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
    
}

extension Character : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let int = sv as? Character {
            return self == int
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
    
}

extension Float : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let float = sv as? Float {
            return self == float
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
    
}

extension Double : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let double = sv as? Double {
            return self == double
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }

}

extension String : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let string = sv as? String {
            return self == string
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
    
}

extension Bool : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let bool = sv as? Bool {
            return self == bool
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }

}

extension Array : TemplateField, TupleField {
    func equals(_ sv : TupleField) -> Bool {
        if let array = sv as? Array<TupleField> {
            if(self.count != array.count){
                return false
            }
            for (ar, value) in zip(array, self) {
                if let t = value as? TemplateField {
                    if !t.match(ar) {
                        return false
                    }
                } else {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
}

/*

//EXAMPLE FUTURE UPDATE
//This feature has been accepted in SE-0143 and is under development.
//https://github.com/apple/swift/blob/master/docs/GenericsManifesto.md#conditional-conformances-
/*
extension Array : SpaceValue where Element : SpaceValue {
    func equals(_ sv : TupleField) -> Bool {
        if let array = sv as? Array<SpaceValue> {
            if(self.count != array.count){
                return false
            }
            for (valueA, valueB) in zip(self, array) {
                if !valueA.equals(valueB) {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
}
*/

extension Set : SpaceValue {
    func equals(_ sv : TupleField) -> Bool  {
        if let set = sv as? Set<Element> {
            if(Element.self is SpaceValue) {
                if(self.count != set.count){
                    return false
                }
                for (indexA, indexB) in zip(self, set) {
                    let spa = indexA as! SpaceValue
                    let spb = indexB as! SpaceValue
                    if !spa.equals(spb) {
                        return false
                    }
                }
                return true
            }
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
}

extension Dictionary : SpaceValue {
    func equals(_ sv : TupleField) -> Bool {
        if let otherD = sv as? Dictionary<Key, SpaceValue> {
            print("DIZIONARIO")
            if(otherD.count != self.count) {
                return false
            }
            print("LUNG UGUALI")
            for key in self.keys {
                if self[key] is SpaceValue {
                    print("E' SPACEVALUE")
                    let value = self[key] as! SpaceValue
                    if !value.equals(otherD[key]!) {
                        return false
                    }
                } else {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func match(_ o: TupleField) -> Bool {
        return self.equals(o)
    }
}

*/
