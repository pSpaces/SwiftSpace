//
//  KeepClientHandler.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 18/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class KeepClientHandler : ClientHandler {
    private var socket : TCPInternetSocket
    private var client : TCPClient?
    private var active = true
    
    init(socket : TCPInternetSocket){
        self.socket = socket
        do {
            self.client = try TCPClient(alreadyConnectedSocket: socket)
        } catch {
            print("Error \(error)")
        }
    }
    
    func receive() -> ClientMessage {
        do {
            let data = try client!.receiveAll()
            let str = String(bytes: data, encoding: String.Encoding.utf8)
            active = true
            let message = ClientMessage.deserialize(from: str)
            if message != nil {
                return message!
            }
        } catch {
            print("Error \(error)")
            active = false
        }
        active = false
        return ClientMessage()
    }
    
    func send(_ msg : ServerMessage) -> Bool {
        if active {
            let str = msg.toJSONString()
            do {
                try client!.send(bytes: [UInt8](str!.utf8))
            } catch {
                print("Error \(error)")
            }
            return true
        } else {
            return false
        }
    }
    
    func isActive() -> Bool {
        return self.active
    }
    
    func close() {
        do {
            try client!.close()
        } catch {
            print("Error \(error)")
        }
    }
}
