//
//  INetworkRouter.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
protocol INetworkRouter {

    /// The target's base `URL`.
    var baseURL: URL? { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HttpMethod { get }

    /// The headers to be used in the request.
    var task: NetworkTask {get}

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    var timeOut: TimeInterval {get}
   
}
extension INetworkRouter{
    var timeOut: TimeInterval{
        return URLSessionConfiguration.default.timeoutIntervalForRequest
    }

    var thread: DispatchQueue {
        return .promises
    }
}
