//
//  FormalTemplateField.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 05/04/17.
//  Copyright © 2017 Federico Ciardi. All rights reserved.
//

struct FormalTemplateField : TemplateField , HandyJSON {
    private var type : TupleField.Type!
    
    init() {}
    
    init(_ type : TupleField.Type) {
        self.type = type
    }
    
    func getType() -> TupleField.Type {
        return type
    }
    
    func match(_ o: TupleField) -> Bool {
        return type(of :o) == type
    }
}
