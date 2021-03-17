//
//  ServiceError.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
enum ServiceError: Error{
    case unableParse
    case incompleteFields
    case custom(error: String)
}
