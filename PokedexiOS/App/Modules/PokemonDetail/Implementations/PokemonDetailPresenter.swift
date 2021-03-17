//
//  MovieDetailPresenter.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
class PokemonDetailPresenter {
    var view: PokemonDetailPresenterToViewProtol?
    var interactor: PokemonDetailPresenterToInteractorProtocol?
    var router:PokemonDetailPresenterToRouterProtocol?
    let pokemon: Pokemon
    init(pokemon: Pokemon){
        self.pokemon = pokemon
    }
}
extension PokemonDetailPresenter:PokemonDetailViewToPresenterProtocol{
    func goBack() {
        router?.popToMovieScreen()
    }
    
    func reloadData() {
        view?.displayLoading()
        interactor?.fetchMovieDetail(id: pokemon.id)
    }
}
extension PokemonDetailPresenter:PokemonDetailInteractorToPresenterProtocol{
    func pokemonDetailFetchedSuccess(pokemonDetail pokemon: Pokemon) {
        view?.display(pokemon: pokemon)
    }
    
    func pokemonDetailFetchFailed(error: String) {
        view?.display(error: error)
    }
    
    
}
