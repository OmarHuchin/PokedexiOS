//
//  String+Utils.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
extension Optional where Wrapped == String{
    var isNullOrEmpty: Bool{
        return self?.isEmpty ?? true
    }
    var safeValue: String{
        return self ?? ""
    }
}
