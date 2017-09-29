//
//  ClientMessage.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class ClientMessage : HandyJSON{
    var messageType : ClientMessageType?
    var interactionMode : InteractionMode?
    var target : String?
    var blocking : Bool?
    var all : Bool?
    var statusCode : String?
    var statusMessage : String?
    var tuple : [TupleFieldStruct]!
    var template : [TemplateFieldStruct]!
    var clientSession : String?
    var serverSession : String?
    var clientURI : URI?
    
    required init() {}
    
    init(messageType : ClientMessageType, interactionMode : InteractionMode?, target : String?, statusCode : String?, statusMessage : String?, tuple : [TupleFieldStruct]?, template : [TemplateFieldStruct]?, blocking : Bool?, all : Bool?, clientSession : String?, serverSession : String?, clientURI : URI?) {
        self.messageType = messageType
        self.interactionMode = interactionMode
        self.target = target
        self.blocking = blocking
        self.all = all
        self.statusCode = statusCode
        self.statusMessage = statusMessage
        self.tuple = tuple
        self.template = template
        self.clientSession = clientSession
        self.serverSession = serverSession
        self.clientURI = clientURI
    }
    
    func getMessageType() -> ClientMessageType? {
        return messageType
    }
    
    func getInteractionMode() -> InteractionMode? {
        return interactionMode
    }
    
    func getTarget() -> String? {
        return target
    }
    
    func setTarget(_ target : String) {
        self.target = target;
    }
    
    func getStatusCode() -> String? {
        return statusCode
    }
    
    func getStatusMessage() -> String? {
        return statusMessage
    }
    
    func getTuple() -> [TupleField]? {
        if tuple != nil {
            return Utils.structToSpaceValue(tuple)
        } else {
            return nil
        }
    }
    
    func getTemplate() -> [TemplateField]? {
        if template != nil {
            return Utils.structToTemplate(template)
        } else {
            return nil
        }
    }
    
    func getClientSession() -> String? {
        return clientSession
    }
    
    func getServerSession() -> String? {
        return serverSession
    }
    
    func getClientURI() -> URI? {
        return clientURI
    }
    
    func isBlocking() -> Bool? {
        return blocking
    }
    
    func getAll() -> Bool? {
        return all
    }
    
    func setClientSession(_ clientSession : String) {
        self.clientSession = clientSession
    }
    
    static func putRequest(_ t : [TupleField]) -> ClientMessage {
        return ClientMessage(messageType: ClientMessageType.PUT_REQUEST, interactionMode: nil, target: nil, statusCode: nil, statusMessage: nil, tuple: Utils.spaceValueToStruct(t), template: nil, blocking: nil, all: nil, clientSession: nil, serverSession: nil, clientURI: nil)
    }
    
    static func getRequest(_ template : [TemplateField]?,_ isBlocking : Bool,_ all : Bool) -> ClientMessage {
        var tempclass : [TemplateFieldStruct]? = nil
        if template != nil {
            tempclass = Utils.templateFieldToStruct(template!)
        }
        return ClientMessage(messageType: ClientMessageType.GET_REQUEST, interactionMode: nil, target: nil, statusCode: nil, statusMessage: nil, tuple: nil, template: tempclass, blocking: isBlocking, all: all, clientSession: nil, serverSession: nil, clientURI: nil)
    }
    
    static func queryRequest(_ template : [TemplateField]?,_ isBlocking : Bool,_ all : Bool) -> ClientMessage {
        var tempclass : [TemplateFieldStruct]? = nil
        if template != nil {
            tempclass = Utils.templateFieldToStruct(template!)
        }
        return ClientMessage(messageType: ClientMessageType.QUERY_REQUEST, interactionMode: nil, target: nil, statusCode: nil, statusMessage: nil, tuple: nil, template: tempclass, blocking: isBlocking, all: all, clientSession: nil, serverSession: nil, clientURI: nil)
    }

}


