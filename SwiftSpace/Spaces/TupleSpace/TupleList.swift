//
//  TupleList.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 20/04/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class TupleList : SpaceDataStructure {
    private var elements = [[TupleField]]()
    
    private var newTuple : NSCondition?
    
    func setNSCondition(_ newTuple : NSCondition) {
        self.newTuple = newTuple
    }
    
    func put(_ tuple : [TupleField]) -> Bool {
        elements.append(tuple)
        newTuple!.broadcast()
        return true
    }
    
    func get(_ fields : [TemplateField]) -> [TupleField] {
        var tuple = [TupleField]()
        while tuple.isEmpty {
            tuple = pickTuple(fields, true)
            if tuple.isEmpty {
                newTuple!.wait()
            }
        }
        return tuple
    }
    
    func getp(_ fields : [TemplateField]) -> [TupleField] {
        return pickTuple(fields, true)
    }
    
    func getAll(_ fields : [TemplateField]? = nil) -> [[TupleField]] {
        var tuples : [[TupleField]]
        if fields == nil {
            tuples = elements
            elements.removeAll()
        } else {
            tuples = pickTuples(fields!, true)
        }
        return tuples
    }
    
    func query(_ fields : [TemplateField]) -> [TupleField] {
        var tuple = [TupleField]()
        while tuple.isEmpty {
            tuple = pickTuple(fields, false)
            if tuple.isEmpty {
                newTuple!.wait()
            }
        }
        return tuple
    }
    
    func queryp(_ fields : [TemplateField]) -> [TupleField] {
        return pickTuple(fields, false)
    }
    
    func queryAll(_ fields : [TemplateField]? = nil) -> [[TupleField]] {
        if fields == nil {
            return elements
        } else {
            return pickTuples(fields!, false)
        }
    }
    
    private func pickTuple(_ fields : [TemplateField],_ remove : Bool) -> [TupleField] {
        var i = 0
        for e in elements {
            if(self.match(fields, e)){
                if remove {
                    elements.remove(at: i)
                }
                return e
            }
            i += 1
        }
        return [TupleField]()
    }
    
    private func pickTuples(_ fields : [TemplateField],_ remove : Bool) -> [[TupleField]] {
        var tuples = [[TupleField]]()
        var i = 0
        for e in elements {
            if(self.match(fields, e)){
                tuples.append(e)
                if remove {
                    elements.remove(at: i)
                    i -= 1
                }
            }
            i += 1
        }
        return tuples
    }
    
    private func match(_ fields : [TemplateField],_ tuple : [TupleField]) -> Bool {
        if fields.count != tuple.count {
            return false
        }
        for (tef, tuf) in zip(fields, tuple) {
            if !tef.match(tuf) {
                return false
            }
        }
        return true
    }
    
}
