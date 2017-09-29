//
//  ServerGate.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

protocol ServerGate : Gate {
    func accept() -> ClientHandler?
    func getURI() -> URI
}
