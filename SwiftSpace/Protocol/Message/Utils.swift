//
//  Utils.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 26/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class Utils {
    static func spaceValueToStruct(_ t : [TupleField]) -> [TupleFieldStruct] {
        var tc = [TupleFieldStruct]()
        for v in t {
            if v is Array<TupleField> {
                tc.append(TupleFieldStruct(value: spaceValueToStruct(v as! Array<TupleField>), type: TypeDictionary.TUPLE_URI))
            } else {
                tc.append(TupleFieldStruct(value: v, type: TypeDictionary.getInstance().getUri(type(of: v))!))
            }
        }
        return tc
    }
    
    static func templateFieldToStruct(_ t : [TemplateField]) -> [TemplateFieldStruct] {
        var tc = [TemplateFieldStruct]()
        for v in t {
            if let f = v as? FormalTemplateField {
                tc.append(TemplateFieldStruct(value: TypeDictionary.getInstance().getUri(f.getType())!, formal: true))
            } else if v is Array<TemplateField> {
                tc.append(TemplateFieldStruct(value: templateFieldToStruct(v as! Array<TemplateField>), formal: false))
            } else {
                let f = v as! TupleField
                tc.append(TemplateFieldStruct(value: TupleFieldStruct(value: v, type: TypeDictionary.getInstance().getUri(type(of: f))!), formal: false))
            }
        }
        return tc
    }

    static func structToSpaceValue(_ tuple : [TupleFieldStruct]) -> [TupleField] {
        var tp = [TupleField]()
        for value in tuple {
            if value.type ==  TypeDictionary.TUPLE_URI {
                let tup = [TupleFieldStruct].deserialize(from: value.value as? NSArray)
                tp.append(structToSpaceValue(tup! as! [TupleFieldStruct]))
            } else {
                let el = castTupleField(value)
                if el != nil {
                    tp.append(el!)
                }
            }
        }
        return tp
    }
    
    private static func castTupleField(_ value : TupleFieldStruct) -> TupleField? {
        if TypeDictionary.getInstance().getClass(value.type) == Bool.self {
            return value.value as! Bool
        } else if TypeDictionary.getInstance().getClass(value.type) == Byte.self {
            return value.value as! Byte
        } else if TypeDictionary.getInstance().getClass(value.type) == Character.self {
            return value.value as! Character
        } else if TypeDictionary.getInstance().getClass(value.type) == Int.self {
            return value.value as! Int
        } else if TypeDictionary.getInstance().getClass(value.type) == Int64.self {
            return value.value as! Int64
        } else if TypeDictionary.getInstance().getClass(value.type) == Float.self {
            return value.value as! Float
        } else if TypeDictionary.getInstance().getClass(value.type) == Double.self {
            return value.value as! Double
        } else if TypeDictionary.getInstance().getClass(value.type) == String.self {
            return value.value as! String
        } else if TypeDictionary.getInstance().getClass(value.type) == Array<TupleField>.self {
            return value.value as! Array<TupleField>
        }
        return nil
    }
    
    private static func castTemplateField(_ value : TupleFieldStruct) -> TemplateField? {
        if TypeDictionary.getInstance().getClass(value.type) == Bool.self {
            return value.value as! Bool
        } else if TypeDictionary.getInstance().getClass(value.type) == Byte.self {
            return value.value as! Byte
        } else if TypeDictionary.getInstance().getClass(value.type) == Character.self {
            return value.value as! Character
        } else if TypeDictionary.getInstance().getClass(value.type) == Int.self {
            return value.value as! Int
        } else if TypeDictionary.getInstance().getClass(value.type) == Int64.self {
            return value.value as! Int64
        } else if TypeDictionary.getInstance().getClass(value.type) == Float.self {
            return value.value as! Float
        } else if TypeDictionary.getInstance().getClass(value.type) == Double.self {
            return value.value as! Double
        } else if TypeDictionary.getInstance().getClass(value.type) == String.self {
            return value.value as! String
        } else if TypeDictionary.getInstance().getClass(value.type) == Array<TupleField>.self {
            return value.value as! Array<TupleField>
        }
        return nil
    }
    
    static func structToTemplate(_ template : [TemplateFieldStruct]) -> [TemplateField] {
        var tp = [TemplateField]()
        for temp in template {
            if  temp.formal != nil && temp.formal! {
                if TypeDictionary.getInstance().getClass(temp.value as! String) == Bool.self {
                    tp.append(FormalTemplateField(Bool.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Byte.self {
                    tp.append(FormalTemplateField(Byte.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Character.self {
                    tp.append(FormalTemplateField(Character.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Int.self {
                    tp.append(FormalTemplateField(Int.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Int64.self {
                    tp.append(FormalTemplateField(Int64.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Float.self {
                    tp.append(FormalTemplateField(Float.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Double.self {
                    tp.append(FormalTemplateField(Double.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == String.self {
                    tp.append(FormalTemplateField(String.self))
                } else if TypeDictionary.getInstance().getClass(temp.value as! String) == Array<TupleField>.self {
                    tp.append(FormalTemplateField(Array<TupleField>.self))
                }
            } else {
                let tem = [TemplateFieldStruct].deserialize(from: temp.value as? NSArray)
                if tem != nil {
                    tp.append(structToTemplate(tem! as! [TemplateFieldStruct]))
                } else {
                    let el = TupleFieldStruct.deserialize(from: temp.value as? NSDictionary)
                    if el != nil {
                        tp.append(castTemplateField(el!)!)
                    }
                }
            }
        }
        return tp
    }
 
}
