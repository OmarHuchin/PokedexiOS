//
//  MovieDetailRouter.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
class PokemonDetailRouter: PokemonDetailPresenterToRouterProtocol{
    weak var navigationViewController: UINavigationController!
    weak var viewController: UIViewController?
   
    static var storyBoard: UIStoryboard{
        return  UIStoryboard(name: "Pokedex", bundle: nil)
    }
    static func createModule(pokemon: Pokemon, navigationViewController: UINavigationController) -> UIViewController {
        let view = PokemonDetailRouter.storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! PokemonDetailViewController
        
        let presenter: PokemonDetailPresenter = PokemonDetailPresenter(pokemon: pokemon)
        let interactor: PokemonDetailPresenterToInteractorProtocol = PokemonDetailInteractor()
        let router:PokemonDetailRouter = PokemonDetailRouter()
        router.viewController = view
        router.navigationViewController = navigationViewController
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    func popToMovieScreen() {
        navigationViewController?.popViewController(animated: true)
    }
}
