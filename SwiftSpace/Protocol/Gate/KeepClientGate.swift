//
//  KeepClientGate.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 18/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class KeepClientGate : ClientGate {
    let host : String
    let port : Int
    let target : String
    
    private var sessionCounter = 0
    
    private var client : TCPClient?
    
    init(_ host : String,_ port: Int,_ target : String) {
        self.host = host
        self.port = port
        self.target = target
    }
    
    func send(m : ClientMessage) -> ServerMessage {
        sessionCounter += 1
        let sessionId = sessionCounter
        m.setClientSession(String(sessionId))
        m.setTarget(target)
        do {
            try client?.send(bytes: [UInt8](m.toJSONString()!.utf8))
            let str = try client?.receiveAll().toString()
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
        do {
            client = try TCPClient(address: InternetAddress(hostname: host, port: Port(port)))
        } catch {
            print("Error \(error)")
        }
    }
    
    func close() {
        do {
            try client?.close()
        } catch {
            print("Error \(error)")
        }
    }
}
