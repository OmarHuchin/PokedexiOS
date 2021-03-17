//
//  DataForm.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Networking
struct DataForm {
    fileprivate let data: Data
    fileprivate let parameterName: String
    fileprivate let filename: String?
    fileprivate let type: DataFormType
    var boundary: String = ""

    var formData: Data {
        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; "
        body += "name=\"\(parameterName)\""
        if let filename = filename {
            body += "; filename=\"\(filename)\""
        }
        body += "\r\n"
        body += "Content-Type: \(type.contentType)\r\n\r\n"

        var bodyData = Data()
        bodyData.append(body.data(using: .utf8)!)
        bodyData.append(data)
        bodyData.append("\r\n".data(using: .utf8)!)

        return bodyData as Data
    }

    public init(type: DataFormType = .data, data: Data, parameterName: String, filename: String? = nil) {
        self.type = type
        self.data = data
        self.parameterName = parameterName
        self.filename = filename
    }
}
extension DataForm{
    var formDataPart : FormDataPart{
        return FormDataPart(type: type.formDataType, data: data, parameterName: parameterName, filename: filename)
    }
}
enum DataFormType {
    case data
    case png
    case jpg
    case custom(String)
    var contentType: String {
        switch self {
        case .data:
            return "application/octet-stream"
        case .png:
            return "image/png"
        case .jpg:
            return "image/jpeg"
        case let .custom(value):
            return value
        }
    }
}
extension DataFormType
{
    var formDataType: FormDataPartType{
        switch self {
        case .data:
            return .data
        case .png:
            return .png
        case .jpg:
            return .jpg
        case .custom(let custom):
            return .custom(custom)
        }
    }
}
