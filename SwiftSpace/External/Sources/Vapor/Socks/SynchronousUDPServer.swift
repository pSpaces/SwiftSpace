//
//  SynchronousUDPServer.swift
//  Socks
//
//  Created by Honza Dvorsky on 6/1/16.
//
//

public class SynchronousUDPServer {
    
    public let address: InternetAddress
    
    public init(address: InternetAddress) throws {
        self.address = address
    }
    
    public convenience init(port: UInt16, bindLocalhost: Bool = false) throws {
        let address: InternetAddress = bindLocalhost ? .localhost(port: port) : .any(port: port)
        try self.init(address: address)
    }
    
    public func startWithHandler(handler: (_ received: [UInt8], _ client: UDPClient) throws -> ()) throws -> Never  {
        
        let server = try UDPInternetSocket(address: address)
        try server.bind()
        
        while true {
            let (data, sender) = try server.recvfrom()
            let client = try UDPClient(address: sender)
            try handler(data, client)
        }
    }
}
