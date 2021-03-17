//
//  MovieCollectionViewCell.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    public func populate(pokemon: Pokemon){
        titleLabel.text = pokemon.name?.capitalized
        voteAverageLabel.text = "\(pokemon.weight)"
        backgroundImageView.setImage(fromPath: pokemon.coverImage)
    }
}
