//
//  GateFactory.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class GateFactory {
    static let LANGUAGE_QUERY_ELEMENT = "lang"
    static let MODE_QUERY_ELEMENT = "mode"
    static let TCP_PROTOCOL = "tcp"
    static let UDP_PROTOCOL = "udp"
    static let HTTP_PROTOCOL = "http"
    static let HTTPS_PROTOCOL = "https"
    
    static let DEFAULT_PROT = "tcp"
    
    private static var instance : GateFactory? = nil
    
    private var gateBuilders = [String : GateBuilder]()
    
    private init(){
        gateBuilders[GateFactory.TCP_PROTOCOL] = TcpGateBuilder()
        //gateBuilders[GateFactory.UDP_PROTOCOL] = UdpGateBuilder()
    }
    
    static func getInstance() -> GateFactory {
        if instance == nil {
            instance = GateFactory()
        }
        return instance!
    }
    
    func getGateBuilder(_ prot : String?) -> GateBuilder {
        if prot != nil {
            return gateBuilders[prot!]!
        }
        return gateBuilders[GateFactory.DEFAULT_PROT]!
    }
}
