//
//  ReadersWriters.swift
//  SwiftSpace
//
//  Created by Federico Ciardi on 21/09/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

let N = 3
let M = 3

let ts = TupleSpace(TupleTree())
_ = ts.put(["SEMAPHORE", N])
_ = ts.put(["RESOURCE", 100])

let queue = DispatchQueue.init(label: "it.SwiftSpace.LS", attributes: .concurrent)


for i in 0...N-1 {
    queue.async {
        let n = i
        for e in 0...99 {
            var sem = ts.get(["SEMAPHORE", FormalTemplateField(Int.self)])
            var num = (sem[1] as! Int) - 1
            _ = ts.put(["SEMAPHORE", num])
            
            let val = ts.query(["RESOURCE", FormalTemplateField(Int.self)])
            print("LETTORE \(i) + LETTO RISORSA CON VALORE \(val[1])")
            
            sem = ts.get(["SEMAPHORE", FormalTemplateField(Int.self)])
            num = (sem[1] as! Int) + 1
            _ = ts.put(["SEMAPHORE", num])
        }
    }
}

for i in 0...M-1 {
    queue.async {
        let n = i
        for e in 0...99 {
            var sem = ts.get(["SEMAPHORE", N])
            let val = ts.get(["RESOURCE", FormalTemplateField(Int.self)])
            let num = (val[1] as! Int) - 1
            _ = ts.put(["RESOURCE", num])
            print("SCRITTORE \(i) + MODIFICATO RISORSA CON VALORE \(num)")
            _ = ts.put(["SEMAPHORE", N])
        }
    }
}

while(true) {
    
}
