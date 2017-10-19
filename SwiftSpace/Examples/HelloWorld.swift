//
//  HelloWorld.swift
//  SwiftSpace
//
//  Created by Federico Ciardi on 19/10/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

let inbox = TupleSpace(TupleList())

_ = inbox.put(["Hello World!"])
let tuple = inbox.get([FormalTemplateField(String.self)])
print(tuple)
