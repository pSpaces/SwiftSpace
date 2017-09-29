//
//  Knowledge.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 28/03/17.
//  Copyright © 2017 Federico Ciardi. All rights reserved.
//

import Foundation

protocol AbstractSpace {
    func put(_ tuple : [TupleField]) -> Bool
    func get(_ fields : [TemplateField]) -> [TupleField]
    func getp(_ fields : [TemplateField]) -> [TupleField]
    func getAll(_ fields : [TemplateField]?) -> [[TupleField]]
    func query(_ fields : [TemplateField]) -> [TupleField]
    func queryp(_ fields : [TemplateField]) -> [TupleField]
    func queryAll(_ fields : [TemplateField]?) -> [[TupleField]]
}

protocol SpaceDataStructure : AbstractSpace {
    func setNSCondition(_ newTuple : NSCondition)
}

protocol Space : AbstractSpace {}
