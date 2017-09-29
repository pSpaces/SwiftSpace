//
//  DiningPhilosophers.swift
//  SwiftSpace
//
//  Created by Federico Ciardi on 22/09/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

let nFilosofi = 5

let table = TupleSpace(TupleTree())
for i in 1...nFilosofi {
    _ = table.put(["FORK", i])
}

let queue = DispatchQueue.init(label: "it.SwiftSpace.Table", attributes: .concurrent)

for i in 1...nFilosofi-1 {
    queue.async {
        while(true) {
            _ = table.get(["FORK", i])
            _ = table.get(["FORK", (i%nFilosofi)+1])
            
            print("Filosofo \(i) sta mangiando...")
            
            _ = table.put(["FORK", i])
            _ = table.put(["FORK", (i%nFilosofi)+1])
            
            //sleep(1)
        }
    }
}
queue.async {
    while(true) {
        _ = table.get(["FORK", 1])
        _ = table.get(["FORK", nFilosofi])
        
        print("Filosofo \(nFilosofi) sta mangiando...")
        
        _ = table.put(["FORK", 1])
        _ = table.put(["FORK", nFilosofi])
        
        //sleep(1)
    }
}


while(true){
    
}
