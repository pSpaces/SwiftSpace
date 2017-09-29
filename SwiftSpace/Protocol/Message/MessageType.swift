//
//  ClientMessageType.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

enum ClientMessageType : String, HandyJSONEnum {
    case PUT_REQUEST = "PUT_REQUEST"
    case GET_REQUEST = "GET_REQUEST"
    case QUERY_REQUEST = "QUERY_REQUEST"
    case ACK = "ACK"
    case FAILURE = "FAILURE"
}

enum ServerMessageType : String, HandyJSONEnum {
    case PUT_RESPONSE = "PUT_RESPONSE"
    case GET_RESPONSE = "GET_RESPONSE"
    case QUERY_RESPONSE = "QUERY_RESPONSE"
    case FAILURE = "FAILURE"
}

enum InteractionMode : String, HandyJSONEnum {
    case KEEP = "KEEP"
    case CONN = "CONN"
    case PUSH = "PUSH"
    case PULL = "PULL"
}

