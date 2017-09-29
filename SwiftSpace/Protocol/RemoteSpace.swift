//
//  RemoteSpace.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 08/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class RemoteSpace : Space {
    private var uri : URI
    private var gate : ClientGate
    
    init(_ uri : URI) {
        self.uri = uri
        self.gate = GateFactory.getInstance().getGateBuilder(uri.prot).createClientGate(uri)!
        self.gate.open();
    }
    
    convenience init(_ uri : String) {
        self.init(URI(uri))
    }
    
    func put(_ tuple: [TupleField]) -> Bool {
        let response = gate.send(m: ClientMessage.putRequest(tuple))
        return response.isSuccessful()
    }
    
    func get(_ fields: [TemplateField]) -> [TupleField] {
        return getI(fields, true)
    }
    
    func getp(_ fields: [TemplateField]) -> [TupleField] {
        return getI(fields, false)
    }

    private func getI(_ fields : [TemplateField],_ isBlocking : Bool) -> [TupleField] {
        let response = gate.send(m: ClientMessage.getRequest(fields, isBlocking, false))
        let tuples = response.getTuples()
        if tuples.count != 0 {
            return tuples[0]
        }
        return [TupleField]()
    }
    
    func getAll(_ fields: [TemplateField]? = nil) -> [[TupleField]] {
        var response : ServerMessage
        if fields != nil {
            response = gate.send(m: ClientMessage.getRequest(fields!, false, true))
        } else {
            response = gate.send(m: ClientMessage.getRequest(nil, false, true))
        }
        return response.getTuples()
    }
    
    func query(_ fields: [TemplateField]) -> [TupleField] {
        return queryI(fields, true)
    }
    
    func queryp(_ fields: [TemplateField]) -> [TupleField] {
        return queryI(fields, false)
    }
    
    func queryI(_ fields: [TemplateField],_ isBlocking : Bool) -> [TupleField] {
        let response = gate.send(m: ClientMessage.queryRequest(fields, isBlocking, false))
        return response.getTuples()[0]
    }
    
    func queryAll(_ fields: [TemplateField]? = nil) -> [[TupleField]] {
        let response = gate.send(m: ClientMessage.queryRequest(fields!, false, true))
        return response.getTuples()
    }
    
    func getURI() -> URI{
        return uri
    }
    
    func getGate() -> ClientGate {
        return gate
    }
}

