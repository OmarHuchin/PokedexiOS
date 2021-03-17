//
//  Protocols.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
protocol PokemonViewToPresenterProtocol {
    func showNowMovies()
    func getSizeItem(collectionView: UICollectionView)-> CGSize
    func didSelect(indexPath: IndexPath)
    func didScroll(scrollView: UIScrollView)
}
protocol PokemonPresenterToViewProtol : class{
    func displayLoading()
    func display(pokemons: [Pokemon])
    func display(error: String)
    func hideLoading()
}
protocol PokemonPresenterToRouterProtocol {
    func pushToDetailPokemonScreen(pokemon: Pokemon)
}
protocol PokemonPresenterToInteractorProtocol: class {
    var presenter:PokemonInteractorToPresenterProtocol? {get set}
    func fetchPokemons()
    func fetchMorePokemons()
    func reloadPokemons()
    func cancelFetch()
    func getPokemon(byIndex index: Int)
}

protocol PokemonInteractorToPresenterProtocol: class {
    func pokemonsFetchedSuccess(pokemons: [Pokemon])
    func pokemonsFetchFailed(error: String)
    func pokemonSelected(pokemon: Pokemon)
    func pokemonsFetchCanceled()
    func pokemonsReseted(pokemons: [Pokemon])
}
