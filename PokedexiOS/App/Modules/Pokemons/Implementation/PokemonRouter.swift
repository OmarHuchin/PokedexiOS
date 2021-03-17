
//
//  Routing.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
class PokemonRouter: PokemonPresenterToRouterProtocol{
    weak var viewController :PokemonsCollectionViewController!
    weak var navigationConroller: UINavigationController!
    static var storyBoard: UIStoryboard{
        return  UIStoryboard(name: "Pokedex", bundle: nil)
    }
    static func createModule() -> UIViewController {
        let movieVC = PokemonRouter.storyBoard.instantiateViewController(withIdentifier: "MoviesCollectionViewController") as! PokemonsCollectionViewController
        let navigationController = UINavigationController.init(rootViewController: movieVC)
        let presenter: PokemonPresenter = PokemonPresenter()
        let interactor: PokemonPresenterToInteractorProtocol = PokemonInteractor()
        let router:PokemonRouter = PokemonRouter()
        router.viewController = movieVC
        router.navigationConroller = navigationController
        movieVC.modalPresentationStyle = .fullScreen
        movieVC.presenter = presenter
        presenter.view = movieVC
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navigationController
    }
    func pushToDetailPokemonScreen(pokemon: Pokemon) {
        let movieDetailViewController = PokemonDetailRouter.createModule(pokemon: pokemon, navigationViewController: navigationConroller)
        movieDetailViewController.modalPresentationStyle = .fullScreen
        navigationConroller.pushViewController(movieDetailViewController, animated: true)
    }
    
}
