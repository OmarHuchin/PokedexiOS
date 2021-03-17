//
//  APIServiceError.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
public class APIServiceError: Codable, Error{
    let message: String?
    let success: Bool
    let code: Int?
    enum CodingKeys: String, CodingKey {
        case message = "status_message"
        case success
        case code = "status_code"
    }
    init(message: String, code: Int? = nil){
        self.message = message
        self.code = code
        self.success = false
    }
}
public enum ErrorType: Equatable, Error{
    public static func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
        switch (lhs, rhs) {
        case (.canceled, .canceled):
            return true
        case let (.api(lhsVal), .api(rhsVal)):
            return lhsVal.code == rhsVal.code
        default:
            return false
        }
    }
    
    case canceled
    case api(code: APIServiceError)
}
