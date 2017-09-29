//
//  SpaceRepository.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 08/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

struct SpaceRepositoryError : Error {
    let message : String
    
    init(_ message : String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

class SpaceRepository {
    private var spaces = [String : Space]()
    private var gates = [ServerGate]()
    
    private let queueGate = DispatchQueue.init(label: "it.SwiftResp.Threads.Gate", attributes: .concurrent)
    private let queueHandler = DispatchQueue.init(label: "it.SwiftResp.Threads.Handler", attributes: .concurrent)
    
    func isEmpty() -> Bool {
        return spaces.isEmpty
    }
    
    func size() -> Int {
        return spaces.count
    }
    
    func add(_ name : String,_ space : Space) throws {
        if spaces[name] != nil {
            throw SpaceRepositoryError("Name is already used in the repository!")
        }
        spaces[name] = space
    }
    
    func get(_ name : String) -> Space? {
        return spaces[name]
    }
    
    func remove(_ name : String) -> Space? {
        return spaces.removeValue(forKey: name)
    }
    
    func addGate(_ uri : String) {
        self.addGate(URI(uri))
    }
    
    func addGate(_ uri : URI) {
        let gate = GateFactory.getInstance().getGateBuilder(uri.prot).createServerGate(uri)
        if gate != nil {
            self.addGate(gate!)
        }
    }
    
    func addGate(_ gate : ServerGate) {
        gates.append(gate)
        queueGate.async() {
            gate.open()
            while(true){
                let handler = gate.accept()
                self.addHandler(handler: handler!)
            }
        }
    }
    
    private func addHandler(handler : ClientHandler) {
        queueHandler.async() {
            while(handler.isActive()) {
                let mes = handler.receive()
                _ = handler.send(self.handle(msg: mes))
            }
            handler.close()
        }
    }
    
    func handle(msg : ClientMessage) -> ServerMessage {
        //print(msg.toJSONString()!)
        let type = msg.getMessageType()
        if type != nil {
            switch type! {
            case ClientMessageType.PUT_REQUEST:
                return handlePutRequest(msg: msg)
            case ClientMessageType.GET_REQUEST:
                return handleGetRequest(msg: msg)
            case ClientMessageType.QUERY_REQUEST:
                return handleQueryRequest(msg: msg)
            default:
                return ServerMessage.badRequest(msg.getClientSession())
            }
        }
        return ServerMessage.badRequest(msg.getClientSession())
    }
    
    func handlePutRequest(msg : ClientMessage) -> ServerMessage {
        let tuple = msg.getTuple()
        let target = msg.getTarget()
        let clientSession = msg.getClientSession()
        if (tuple == nil || target == nil) {
            return ServerMessage.badRequest(clientSession!)
        }
        return ServerMessage.putResponse(put(target!, tuple!), clientSession!)
    }
    
    func handleQueryRequest(msg : ClientMessage) -> ServerMessage {
        let target = msg.getTarget()
        let template = msg.getTemplate()
        if target == nil {
            return ServerMessage.badRequest(msg.getClientSession()!)
        }
        if template == nil && msg.getAll() == false {
            return ServerMessage.badRequest(msg.getClientSession()!)
        }
        let tuples = query(msg.getTemplate(), msg.isBlocking()!, msg.getAll()!, msg.getTarget()!)
        if(tuples != nil) {
            return ServerMessage.getResponse(tuples!, msg.getClientSession()!)
        } else {
            return ServerMessage.badRequest(msg.getClientSession()!)
        }
    }
    
    func handleGetRequest(msg : ClientMessage) -> ServerMessage {
        let target = msg.getTarget()
        let template = msg.getTemplate()
        if target == nil {
            return ServerMessage.badRequest(msg.getClientSession()!)
        }
        if template == nil && msg.getAll() == false {
            return ServerMessage.badRequest(msg.getClientSession()!)
        }
        let tuples = get(msg.getTemplate(), msg.isBlocking()!, msg.getAll()!, msg.getTarget()!)
        if(tuples != nil) {
            return ServerMessage.getResponse(tuples!, msg.getClientSession()!)
        } else {
            return ServerMessage.badRequest(msg.getClientSession()!)
        }
    }
    
    private func get(_ template : [TemplateField]?,_ blocking : Bool,_ all : Bool,_ target : String) -> [[TupleField]]? {
        let space = spaces[target]
        if space == nil {
            return nil
        }
        if all {
            return space!.getAll(template)
        }
        var tuples = [[TupleField]]()
        if blocking {
            tuples.append(space!.get(template!))
        } else {
            tuples.append(space!.getp(template!))
        }
        return tuples
    }
    
    private func query(_ template : [TemplateField]?,_ blocking : Bool,_ all : Bool,_ target : String) -> [[TupleField]]? {
        let space = spaces[target]
        if space == nil {
            return nil
        }
        if all {
            return space!.queryAll(template)
        }
        var tuples = [[TupleField]]()
        if blocking {
            tuples.append(space!.query(template!))
        } else {
            tuples.append(space!.queryp(template!))
        }
        return tuples
    }
    
    private func put(_ target : String,_ tuple : [TupleField]) -> Bool {
        let space = spaces[target]
        if space == nil {
            return false
        }
        return space!.put(tuple)
    }
    
    func finalize() {
        for gate in gates {
            gate.close()
        }
    }
    
}
