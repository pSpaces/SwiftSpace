//
//  main.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 06/05/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

let rep = SpaceRepository()
let albero = TupleSpace(TupleTree())

do {
    try rep.add("Albero", albero)
} catch {
    print("Error \(error)")
}

rep.addGate("tcp://192.168.1.68:9090/?keep")

sleep(2)

var remote = RemoteSpace("tcp://80.182.103.158:9091/space?keep")

while(true){
    print(albero.get([FormalTemplateField(String.self)]))
    let response = readLine()
    _ = remote.put([response!])
}
