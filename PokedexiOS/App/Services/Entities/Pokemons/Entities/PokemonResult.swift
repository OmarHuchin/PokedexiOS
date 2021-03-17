//
//  PlayResult.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
public struct PokemonResult: Codable {
    let next: String?
    let previous: String?
    let results: [PokemonMin]?
    let count: Int
}
struct PokemonMin: Codable{
    let name: String
    let url: String
}
