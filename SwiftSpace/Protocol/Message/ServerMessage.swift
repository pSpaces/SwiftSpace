//
//  ServerMessage.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

class ServerMessage : HandyJSON {
    static let CODE200 = "200"
    static let OK_STATUS = "OK"
    static let CODE400 = "400"
    static let BAD_REQUEST = "Bad Request"
    static let CODE500 = "500"
    static let SERVER_ERROR = "Internal Server Error"
    
    private var messageType : ServerMessageType!
    private var interactionMode : InteractionMode?
    private var status : Bool!
    private var statusCode : String!
    private var statusMessage : String!
    private var tuples : [[TupleFieldStruct]]!
    private var clientSession : String?
    private var serverSession : String?
    
    required init() {}
    
    init(messageType : ServerMessageType, interactionMode : InteractionMode?, status : Bool, statusCode : String, statusMessage : String, tuples : [[TupleFieldStruct]]?, clientSession : String?, serverSession : String?) {
        self.messageType = messageType
        self.interactionMode = interactionMode
        self.status = status
        self.statusCode = statusCode
        self.statusMessage = statusMessage
        self.tuples = tuples
        self.clientSession = clientSession
        self.serverSession = serverSession
    }
    
    func getMessageType() -> ServerMessageType {
        return messageType
    }
    
    func getInteractionMode() -> InteractionMode? {
        return interactionMode
    }
    
    func getStatusCode() -> String {
        return statusCode
    }
    
    func getStatusMessage() -> String {
        return statusMessage
    }
    
    func getTuples() -> [[TupleField]] {
        var tuples = [[TupleField]]()
        if self.tuples != nil {
            for tuple in self.tuples {
                tuples.append(Utils.structToSpaceValue(tuple))
            }
        }
        return tuples
    }
    
    func getClientSession() -> String? {
        return clientSession
    }
    
    func getServerSession() -> String? {
        return serverSession
    }
    
    func isSuccessful() -> Bool {
        return status
    }
    
    static func putResponse(_ status : Bool,_ clientSession : String) -> ServerMessage {
        return ServerMessage(messageType: ServerMessageType.PUT_RESPONSE, interactionMode: nil, status: status, statusCode: ServerMessage.CODE200, statusMessage: ServerMessage.OK_STATUS, tuples: nil, clientSession: clientSession, serverSession: nil)
    }
    
    static func badRequest(_ clientSession : String?) -> ServerMessage {
        return ServerMessage(messageType: ServerMessageType.FAILURE, interactionMode: nil, status: false, statusCode: ServerMessage.CODE400, statusMessage: ServerMessage.BAD_REQUEST, tuples: nil, clientSession: clientSession, serverSession: nil)
    }
    
    static func internalServerError() -> ServerMessage {
        return ServerMessage(messageType: ServerMessageType.FAILURE, interactionMode: nil, status: false, statusCode: ServerMessage.CODE500, statusMessage: ServerMessage.SERVER_ERROR, tuples: nil, clientSession: nil, serverSession: nil)
    }
    
    static func getResponse(_ tuples : [[TupleField]],_ clientSession : String) -> ServerMessage {
        var tc = [[TupleFieldStruct]]()
        for tuple in tuples {
            tc.append(Utils.spaceValueToStruct(tuple))
        }
        return ServerMessage(messageType: ServerMessageType.GET_RESPONSE, interactionMode: nil, status: true, statusCode: ServerMessage.CODE200, statusMessage: ServerMessage.OK_STATUS, tuples: tc, clientSession: clientSession, serverSession: nil)
    }

}


