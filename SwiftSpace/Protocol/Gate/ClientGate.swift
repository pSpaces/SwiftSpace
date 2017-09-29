//
//  ClientGate.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 08/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

protocol ClientGate : Gate {
    func send(m : ClientMessage) -> ServerMessage
}
