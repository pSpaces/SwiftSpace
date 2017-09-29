//
//  ConnServerGate.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 10/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class ConnServerGate : ServerGate {
    private let CONN_CODE = "CONN"
    private var server : TCPInternetSocket?
    
    private let host : String
    private let port : Int
    
    init(_ host : String,_ port : Int) {
        self.host = host
        self.port = port
    }
    
    func open() {
        do {
            self.server = try TCPInternetSocket(address: InternetAddress(hostname: self.host, port: Port(self.port)))
            try self.server!.bind()
            try self.server!.listen()
            print("Listening on \"\(self.host)\" - \(self.port)")
        } catch {
            print("Error \(error)")
        }
    }
    
    
    func close() {
        do {
            try server?.close()
        } catch {
            print("Error \(error)")
        }
    }
    
    func accept() -> ClientHandler? {
        do {
            let socket = try self.server?.accept()
            return ConnClientHandler(socket: socket!);
        } catch {
            print("Error \(error)")
        }
        return nil
    }
    
    func getURI() -> URI {
        return URI(prot: "socket", host: host, port: port, mode: CONN_CODE)
    }
    
}
