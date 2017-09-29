//
//  ConnClientGate.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class ConnClientGate : ClientGate {
    let host : String
    let port : Int
    let target : String
    
    init(_ host : String,_ port: Int,_ target : String) {
        self.host = host
        self.port = port
        self.target = target
    }
    
    func send(m : ClientMessage) -> ServerMessage {
        do {
            let client = try TCPClient(address: InternetAddress(hostname: host, port: Port(port)))
            m.setClientSession("-1")
            m.setTarget(target)
            try client.send(bytes: [UInt8](m.toJSONString()!.utf8))
            let str = try client.receiveAll().toString()
            try client.close()
            let message = ServerMessage.deserialize(from: str)
            if message != nil {
                return message!
            }
        } catch {
            print("Error \(error)")
        }
        return ServerMessage.internalServerError()
    }
    
    func open() {
        
    }
    
    func close() {
        
    }
}
