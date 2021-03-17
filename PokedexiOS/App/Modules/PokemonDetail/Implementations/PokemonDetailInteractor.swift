//
//  MoviDetailInteractor.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
class PokemonDetailInteractor: PokemonDetailPresenterToInteractorProtocol{
    var presenter:PokemonDetailInteractorToPresenterProtocol?
    func fetchMovieDetail(id: Int?) {
        guard let id = id else{
            presenter?.pokemonDetailFetchFailed(error: "Pokemon no valido")
            return
        }
        PokemonDetailService.getPokemon(id: id).delay(0).then { (pokemonDetail) in
            var pokemon = pokemonDetail
            pokemon.name = pokemon.name?.capitalized
            pokemon.coverImage = "\(NetworkService.imageHost)\(pokemon.id).png"
            pokemon.frontImage = pokemon.sprites?.frontDefault
            pokemon.url = "\(NetworkService._baseUrl)\(pokemon.id)"
            self.presenter?.pokemonDetailFetchedSuccess(pokemonDetail: pokemon)
        }.catch { (error) in
            if let error = error as? APIServiceError{
                self.presenter?.pokemonDetailFetchFailed(error: error.message.safeValue)
            }
            
        }
    }
}
