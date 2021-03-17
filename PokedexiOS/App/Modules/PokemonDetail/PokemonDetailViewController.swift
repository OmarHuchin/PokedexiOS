//
//  MovieDetailViewController.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, PokemonDetailPresenterToViewProtol {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textContainerStackView: UIStackView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationDetailStackView: DetailStackView!
    @IBOutlet weak var releaseDateDetailStackView: DetailStackView!
    @IBOutlet weak var voteAverageDetailStackView: DetailStackView!
    @IBOutlet weak var genresDetailStackView: DetailStackView!
    @IBOutlet weak var descriptionDetailStackView: DetailStackView!
    weak var activityIndicator: UIActivityIndicatorView!
    var presenter: PokemonDetailPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    func displayLoading() {
        self.activityIndicator.isHidden = false
        self.containerView.isHidden = true
        self.activityIndicator.startAnimating()
    }
    func display(pokemon: Pokemon) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.containerView.isHidden = false
        titleLabel.text = pokemon.name
        posterImageView.setImage(fromPath: pokemon.coverImage)
        durationDetailStackView.isHidden = true
        releaseDateDetailStackView.isHidden = true
        voteAverageDetailStackView.isHidden = true
        genresDetailStackView.isHidden = true
        descriptionDetailStackView.title = "Peso:"
        descriptionDetailStackView.descriptionText  = "\(pokemon.weight)"
    }
    
    func display(error: String) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
