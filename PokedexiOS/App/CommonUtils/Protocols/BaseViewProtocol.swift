//
//  BaseViewProtocol.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
protocol BaseViewProtocol{
    typealias T = Codable
    func display<T>(item: T)
    func display(error: String)
}
