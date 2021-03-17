//
//  MovieDetailProtocols.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
protocol PokemonDetailViewToPresenterProtocol {
    func goBack()
    func reloadData()
}
protocol PokemonDetailPresenterToViewProtol {
    var presenter: PokemonDetailPresenter? { get set }
    func displayLoading()
    func display(pokemon: Pokemon)
    func display(error: String)
}
protocol PokemonDetailPresenterToRouterProtocol {
    func popToMovieScreen()
}
protocol PokemonDetailPresenterToInteractorProtocol: class {
    var presenter:PokemonDetailInteractorToPresenterProtocol? {get set}
    func fetchMovieDetail(id: Int?)
}

protocol PokemonDetailInteractorToPresenterProtocol: class {
    func pokemonDetailFetchedSuccess(pokemonDetail: Pokemon)
    func pokemonDetailFetchFailed(error: String)
}
