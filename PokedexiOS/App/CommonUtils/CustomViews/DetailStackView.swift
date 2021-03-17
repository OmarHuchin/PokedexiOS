//
//  DetailStackView.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import UIKit
@IBDesignable
class DetailStackView: UIStackView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBInspectable var title: String = "" {
        didSet {
            self.titleLabel?.text = title
        }
    }
    @IBInspectable var descriptionText: String? = "" {
        didSet {
            self.isHidden = descriptionText.isNullOrEmpty
            self.descriptionLabel?.text = descriptionText
        }
    }
    func setup(title: String,_ description: String?){
        self.title = title
        self.descriptionText = description
    }
}
