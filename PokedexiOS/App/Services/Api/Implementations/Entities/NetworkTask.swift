//
//  NetworkTask.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
/// Represents an HTTP task.
enum NetworkTask {
    /// A request with no additional data.
    case requestPlain

    /// A requests body set with data.
    case requestData(Data)

    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)

    /// A requests body set with encoded parameters.
    case requestParametersEncoding(parameters: [String: Any], encoding: ParameterEncoding)
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any])

    /// A requests body set with encoded parameters combined with url parameters.
    case requestCompositeParameters(bodyParameters: [String: Any], bodyEncoding: ParameterEncoding, urlParameters: [String: Any])

    /// A "multipart/form-data" upload task.
    case uploadMultipart([DataForm])

    /// A "multipart/form-data" upload task  combined with url parameters.
    case uploadCompositeMultipart([DataForm], urlParameters: [String: Any], encoding: ParameterEncoding)

}
extension NetworkTask{
    var encoding: ParameterEncoding{
        switch self{
        case .requestPlain:
            return .none
        case .requestData(_):
            return .none
        case .requestJSONEncodable(_):
            return .json
        case .requestParametersEncoding(parameters: _, encoding: let encoding):
            return encoding
        case .requestParameters(parameters: _):
            return .json
        case .requestCompositeParameters(bodyParameters: _, bodyEncoding: let bodyEncoding, urlParameters: _):
            return bodyEncoding
        case .uploadMultipart(_):
            return .none
        case .uploadCompositeMultipart(_, urlParameters: _, let encoding):
            return encoding
        }
    }
    var parameters: [String:Any]?{
        switch self{
        case .requestPlain:
            return nil
        case .requestData(_):
            return nil
        case .requestJSONEncodable(_):
            return nil
        case .requestParameters(let parameters):
            return parameters
        case .requestParametersEncoding(let parameters, encoding: _):
            return parameters
        case .requestCompositeParameters(let parameters, bodyEncoding: _, urlParameters: _):
            return parameters
        case .uploadMultipart(_):
            return nil
        case .uploadCompositeMultipart(_, let parameters, _):
            return parameters
        }
    }
   
}
extension NetworkTask{
    
}
