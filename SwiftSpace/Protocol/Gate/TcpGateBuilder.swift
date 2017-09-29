//
//  TcpGateBuilder.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class TcpGateBuilder : GateBuilder {
    static let DEFAULT_PORT = 31415
    static let DEFAULT_MODE = "KEEP"
    
    static let KEEP_MODE = "KEEP"
    static let CONN_MODE = "CONN"
    static let PUSH_MODE = "PUSH"
    static let PULL_MODE = "PULL"
    
    
    func createClientGate(_ uri : URI) -> ClientGate? {
        let host = uri.host
        var port = uri.port
        var mode = uri.mode
        let space = uri.space
        
        if space == nil {
            return nil
        }
        
        if mode == nil {
            mode = TcpGateBuilder.DEFAULT_MODE
        }
        mode = mode!.uppercased()
        
        if port == nil || port! < 0 {
            port = TcpGateBuilder.DEFAULT_PORT
        }
        
        if TcpGateBuilder.KEEP_MODE == mode {
            return KeepClientGate(host!, port!, space!)
        } else if TcpGateBuilder.CONN_MODE == mode {
            return ConnClientGate(host!, port!, space!)
        }
        return nil
    }
    
    func createServerGate(_ uri : URI) -> ServerGate? {
        let host = uri.host
        var port = uri.port
        var mode = uri.mode
        
        if mode == nil {
            mode = TcpGateBuilder.DEFAULT_MODE
        }
        mode = mode!.uppercased()
        
        if port == nil || port! < 0 {
            port = TcpGateBuilder.DEFAULT_PORT
        }

        if TcpGateBuilder.KEEP_MODE == mode {
            return KeepServerGate(host!, port!)
        } else if TcpGateBuilder.CONN_MODE == mode {
            return ConnServerGate(host!, port!)
        }
        return nil
    }
}
