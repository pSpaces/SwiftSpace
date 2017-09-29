//
//  ClientHandler.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

protocol ClientHandler {
    func receive() -> ClientMessage
    func send(_ m : ServerMessage) -> Bool
    func isActive() -> Bool
    func close()
}
