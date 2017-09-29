//
//  TypeDictionary.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 26/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

struct TupleMetatype : Hashable {
    
    let base: TupleField.Type
    
    static func ==(lhs: TupleMetatype, rhs: TupleMetatype) -> Bool {
        return lhs.base == rhs.base
    }
    
    init(_ base: TupleField.Type) {
        self.base = base
    }
    
    var hashValue: Int {
        return ObjectIdentifier(base).hashValue
    }
}


class TypeDictionary {
    public static let BOOLEAN_URI = "pspace:boolean"
    public static let BYTE_URI = "pspace:byte"
    public static let CHAR_URI = "pspace:char"
    public static let INTEGER_URI = "pspace:int"
    public static let LONG_URI = "pspace:long"
    public static let FLOAT_URI = "pspace:float"
    public static let DOUBLE_URI = "pspace:double"
    public static let STRING_URI = "pspace:string"
    public static let TUPLE_URI = "pspace:tuple"
    public static let TEMPLATE_URI = "pspace:template"
    
    private var uriToClass = [String : TupleField.Type ]()
    private var classToUri = [TupleMetatype : String]()
    
    private static var instance : TypeDictionary? = nil
    
    static func getInstance() -> TypeDictionary {
        if instance == nil {
            instance = TypeDictionary()
        }
        return instance!
    }
    
    private init() {
        uriToClass[TypeDictionary.BOOLEAN_URI] = Bool.self
        uriToClass[TypeDictionary.BYTE_URI] = Byte.self
        uriToClass[TypeDictionary.CHAR_URI] = Character.self
        uriToClass[TypeDictionary.INTEGER_URI] = Int.self
        uriToClass[TypeDictionary.LONG_URI] =  Int64.self
        uriToClass[TypeDictionary.FLOAT_URI] = Float.self
        uriToClass[TypeDictionary.DOUBLE_URI] = Double.self
        uriToClass[TypeDictionary.STRING_URI] = String.self
        uriToClass[TypeDictionary.TUPLE_URI] = Array<TupleField>.self
        uriToClass[TypeDictionary.TEMPLATE_URI] = Array<TemplateField>.self
        
        classToUri[TupleMetatype(Bool.self)] = TypeDictionary.BOOLEAN_URI
        classToUri[TupleMetatype(Byte.self)] = TypeDictionary.BYTE_URI
        classToUri[TupleMetatype(Character.self)] = TypeDictionary.CHAR_URI
        classToUri[TupleMetatype(Int.self)] = TypeDictionary.INTEGER_URI
        classToUri[TupleMetatype(Int64.self)] = TypeDictionary.LONG_URI
        classToUri[TupleMetatype(Float.self)] = TypeDictionary.FLOAT_URI
        classToUri[TupleMetatype(Double.self)] = TypeDictionary.DOUBLE_URI
        classToUri[TupleMetatype(String.self)] = TypeDictionary.STRING_URI
        classToUri[TupleMetatype(Array<TupleField>.self)] = TypeDictionary.TUPLE_URI
        classToUri[TupleMetatype(Array<TemplateField>.self)] = TypeDictionary.TEMPLATE_URI
    }

    func isRegistered(_ uri : String) -> Bool {
        return uriToClass[uri] != nil
    }
    
    func isRegistered(_ type : TupleField.Type) -> Bool {
        return classToUri[TupleMetatype(type)] != nil
    }
    
    func register(_ type : TupleField.Type,_ uri : String) -> Bool {
        if( !isRegistered(uri) || !isRegistered(type) ) {
            uriToClass[uri] = type.self
            classToUri[TupleMetatype(type)] = uri
            return true
        }
        return false
    }
    
    func getClass(_ uri : String) -> TupleField.Type? {
        if uriToClass[uri] != nil {
            return uriToClass[uri]
        }
        return nil
    }
    
    func getUri(_ type : TupleField.Type) -> String? {
            if classToUri[TupleMetatype(type)] != nil {
                return classToUri[TupleMetatype(type)]
            }
            return nil
    }
}
