//
//  URI.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 08/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class URI : HandyJSON {
    var prot : String? = nil
    var host : String!
    var port : Int? = nil
    var space : String? = nil
    var mode : String? = nil
    
    required init(){}
    
    init(prot : String, host : String, port : Int, mode : String) {
        self.prot = prot
        self.host = host
        self.port = port
        self.mode = mode
    }

    init(_ uri : String) {
        var temp = uri.components(separatedBy: "?")
        
        if temp.count == 2 {
            mode = temp[1]
        }
        
        temp = temp[0].components(separatedBy: "://")
        if temp.count == 2 {
            prot = temp[0]
            temp[0] = temp[1]
        }
        
        temp = temp[0].components(separatedBy: "/")
        if temp.count == 2 {
            if temp[1] != "" {
                space = temp[1]
            }
        }
        
        temp = temp[0].components(separatedBy: ":")
        if temp.count == 2 {
            port = Int(temp[1])
        }
        
        host = temp[0]
    }
}
