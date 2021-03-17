//
//  PlayMovie.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
public struct Pokemon: Codable{
    let id: Int
    var name: String?
    let order: Int
    let weight: Int
    var url: String? = ""
    var coverImage: String? = ""
    var frontImage: String? = ""
    let sprites: Sprites?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight
        case order
        case sprites
    }
    init() {
        id = 0
        name = ""
        order = 0
        weight = 0
        sprites = nil
    }
}
public struct Sprites: Codable{
    let backDefault: String?
    let frontDefault: String?
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
}
