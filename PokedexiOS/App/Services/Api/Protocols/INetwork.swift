//
//  INetwork.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Promises
import Networking

protocol INetwork{
    func request<T: Codable>(_ request: INetworkRouter, type: T.Type )->Promise<T>
}

