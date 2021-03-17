//
//  NetworkTask+Networking.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Networking
extension NetworkTask{
    var data: [FormDataPart]?{
        switch self{
        case .requestPlain,.requestData(_),.requestParameters(parameters: _),.requestParametersEncoding(parameters: _, encoding: _),.requestCompositeParameters(bodyParameters: _, bodyEncoding: _, urlParameters: _),.requestJSONEncodable(_):
            return nil
        case .uploadMultipart(let dataForms):
            return dataForms.map({$0.formDataPart})
        case .uploadCompositeMultipart(let dataForms, urlParameters: _, encoding: _):
            return dataForms.map({$0.formDataPart})
        }
    }
    var parameterType: Networking.ParameterType{
        switch self{
        case .requestPlain:
            return .none
        case .requestData(_):
            return .none
        case .requestJSONEncodable(_):
            return .json
        case .requestParameters(parameters: _):
            return .json
        case .requestParametersEncoding(parameters: _, encoding: let encoding):
            return encoding.parameterType
        case .requestCompositeParameters(bodyParameters: _, bodyEncoding: let bodyEncoding, urlParameters: _):
            return bodyEncoding.parameterType
        case .uploadMultipart(_):
            return .none
        case .uploadCompositeMultipart(_, urlParameters: _, encoding: let encoding):
            return encoding.parameterType
        }
    }
}
