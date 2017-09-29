//
//  TupleTree.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 13/04/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class TupleTree : SpaceDataStructure {
    private var value : TupleField
    private var counter = 0
    private var father : TupleTree?
    private var sons = [TupleTree]()
    
    private var newTuple : NSCondition?
    
    convenience init(){
        self.init("ROOT", nil)
    }
    
    init(_ value : TupleField,_ father : TupleTree? = nil) {
        self.value = value
        self.father = father
    }
    
    func setNSCondition(_ newTuple: NSCondition) {
        self.newTuple = newTuple
    }
    
    func put(_ tuple : [TupleField]) -> Bool{
        if !tuple.isEmpty {
            for n in sons {
                if n.value.equals(tuple[0]) {
                    recursiveSubTuple(tuple, n)
                    return true
                }
            }
            recursiveSubTuple(tuple, generateChild(tuple[0], self))
        } else {
            if father != nil {
                counter += 1
                newTuple!.broadcast()
            }
        }
        return true
    }
    
    private func generateChild(_ value : TupleField,_ father : TupleTree) -> TupleTree {
        let node = TupleTree(value, father)
        node.setNSCondition(newTuple!)
        sons.append(node)
        return node
    }
    
    private func recursiveSubTuple(_ tuple : [TupleField],_ node : TupleTree) {
        var t = tuple
        t.remove(at: 0)
        _ = node.put(t)
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
    
    private func pickTuple(_ fields : [TemplateField],_ remove : Bool,_ t : [TupleField] = []) -> [TupleField] {
        for n in sons {
            var tuple = t
            tuple.append(n.value)
            if fields[tuple.count-1].match(n.value) {
                if fields.count == tuple.count && n.counter > 0 {
                    if remove {
                        n.decreaseCounter()
                    }
                    return tuple
                } else if fields.count>tuple.count {
                    let res = n.pickTuple(fields, remove, tuple)
                    if !res.isEmpty {
                        return res
                    }
                }
            }
        }
        return []
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
    
    private func decreaseCounter(_ quantity : Int = 1) {
        counter -= quantity
        checkDel()
    }
    
    private func checkDel() {
        if father != nil {
            if(sons.count==0 && counter <= 0){
                delFromFather()
                father!.checkDel()
            }
        }
    }
    
    private func delFromFather() {
        for i in 0...father!.sons.count-1 {
            if father!.sons[i].value.equals(self.value) {
                father!.sons.remove(at: i)
                return
            }
        }
    }
    
    func queryAll(_ fields : [TemplateField]? = nil) -> [[TupleField]] {
        if fields != nil && !fields!.isEmpty {
            return pickTuples(fields!, false)
        } else {
            return visitTree()
        }
    }
    
    
    func getAll(_ fields : [TemplateField]? = nil) -> [[TupleField]] {
        if fields != nil && !fields!.isEmpty {
            return pickTuples(fields!, true)
        } else {
            let res = visitTree()
            sons = [TupleTree]()
            return res
        }
    }
    
    private func pickTuples(_ fields : [TemplateField],_ remove : Bool,_ t : [TupleField] = []) -> [[TupleField]] {
        var tuples = [[TupleField]]()
        for n in sons {
            var tuple = t
            tuple.append(n.value)
            if fields[tuple.count-1].match(n.value) {
                if fields.count == tuple.count && n.counter > 0 {
                    for _ in 0...n.counter-1 {
                        tuples.append(tuple)
                    }
                    if remove {
                        n.decreaseCounter(n.counter)
                    }
                    return tuples
                } else if fields.count>tuple.count {
                    let res = n.pickTuples(fields, remove, tuple)
                    tuples += res
                }
            }
        }
        return tuples
    }
    
    private func visitTree(_ t: [TupleField] = []) -> [[TupleField]] {
        var tuples = [[TupleField]]()
        for n in sons {
            var tuple = t
            tuple.append(n.value)
            let res = n.visitTree(tuple)
            tuples += res
            if n.counter > 0 {
                for _ in 0...n.counter-1 {
                    tuples.append(tuple)
                }
            }
        }
        return tuples
    }
    
}
