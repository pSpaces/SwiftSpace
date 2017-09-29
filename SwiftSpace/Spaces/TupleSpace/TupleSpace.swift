//
//  TupleSpace.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 03/04/17.
//  Copyright © 2017 Federico Ciardi. All rights reserved.
//

import Foundation

class TupleSpace : Space {
    private var elements : SpaceDataStructure
    
    private var newTuple = NSCondition()
    
    init(_ elements : SpaceDataStructure) {
        self.elements = elements
        elements.setNSCondition(newTuple)
    }
    
    func put(_ tuple : [TupleField]) -> Bool {
        var res = false
        newTuple.lock()
            res = elements.put(tuple)
        newTuple.unlock()
        return res
    }
    
    func get(_ fields : [TemplateField]) -> [TupleField] {
        var res = [TupleField]()
        newTuple.lock()
            res = elements.get(fields)
        newTuple.unlock()
        return res
    }
    
    func getp(_ fields : [TemplateField]) -> [TupleField] {
        var res = [TupleField]()
        newTuple.lock()
            res = elements.getp(fields)
        newTuple.unlock()
        return res
    }
    
    func getAll(_ fields : [TemplateField]? = nil) -> [[TupleField]] {
        var res = [[TupleField]]()
        newTuple.lock()
            res = elements.getAll(fields)
        newTuple.unlock()
        return res
    }
    
    func query(_ fields : [TemplateField]) -> [TupleField] {
        var res = [TupleField]()
        newTuple.lock()
            res = elements.query(fields)
        newTuple.unlock()
        return res
    }
    
    func queryp(_ fields : [TemplateField]) -> [TupleField] {
        var res = [TupleField]()
        newTuple.lock()
            res = elements.queryp(fields)
        newTuple.unlock()
        return res
    }
    
    func queryAll(_ fields : [TemplateField]? = nil) -> [[TupleField]] {
        var res = [[TupleField]]()
        newTuple.lock()
            res = elements.queryAll(fields)
        newTuple.unlock()
        return res
    }
    
}
