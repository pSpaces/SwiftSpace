//
//  GateBuilder.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 09/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import Foundation

protocol GateBuilder {
    func createClientGate(_ uri : URI) -> ClientGate?
    func createServerGate(_ uri : URI) -> ServerGate?
}
