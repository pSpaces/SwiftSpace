//
//  PingPong.swift
//  SwiftSpace
//
//  Created by Federico Ciardi on 21/09/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

let ping = TupleSpace(TupleTree())
let pong = TupleSpace(TupleTree())
let queue = DispatchQueue.init(label: "it.SwiftSpace.PP")

queue.async {
    for i in 0...4 {
        _ = ping.get(["PING"])
        print("T1: I have PING!")
        _ = pong.put(["PONG"])
    }
    print("T1 DONE!!!!!")
}

for i in 0...4 {
    _ = ping.put(["PING"])
    _ = pong.get(["PONG"])
    print("T2: I have PONG!")
}
print("T2 DONE!!!!!")
