//
//  UIImageView+KF.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit
extension UIImageView{
    func setImage(fromPath path: String?){
        guard let path = path else {
            return
        }
        var fullPath = path
        if(!path.contains("http")){
            fullPath = "\(NetworkService.imageHost)\(path)"
        }
        let url = URL(string: fullPath)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
