//
//  ParameterEncoding+Networking.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Networking
extension ParameterEncoding{
    var parameterType: Networking.ParameterType{
        switch self {
        case .none:
            return .none
        case .json:
            return .json
        case .formURLEncoded:
            return .formURLEncoded
        case .multipartFormData:
            return .multipartFormData
        case .custom(let value):
            return .custom(value)
        }
    }
}
