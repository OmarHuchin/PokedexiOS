//
//  NetworkEnums.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
enum HttpMethod{
    case post,get,put,upload
}
public enum ParameterEncoding {
       case none, json, formURLEncoded, multipartFormData, custom(String)
       func contentType(_ boundary: String) -> String? {
           switch self {
           case .none:
               return nil
           case .json:
               return "application/json"
           case .formURLEncoded:
               return "application/x-www-form-urlencoded"
           case .multipartFormData:
               return "multipart/form-data; boundary=\(boundary)"
           case let .custom(value):
               return value
           }
       }
}
