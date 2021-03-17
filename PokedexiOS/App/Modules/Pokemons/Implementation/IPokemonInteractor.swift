//
//  IPokemonInteractor.swift
//  PokedexiOS
//
//  Created by Omar Huchin on 17/03/21.
//  Copyright © 2021 Omar.Huchin. All rights reserved.
//

import Foundation
import Foundation
import Promises
class PokemonInteractor: PokemonPresenterToInteractorProtocol{
    var pokemons: [Pokemon] = [Pokemon]()
    var currentPage: String = ""
    var limit = 20
    var presenter:PokemonInteractorToPresenterProtocol?
    var currentPromise: Promise<PokemonResult>?
    func fetchPokemons() {
        fecthNowpokemons(withDelay: 0)
    }
    func getPokemon(byIndex index: Int) {
        guard 0..<pokemons.count ~= index  else{
            return
        }
        let pokemon = pokemons[index]
        presenter?.pokemonSelected(pokemon: pokemon)
    }
    func fetchMorePokemons() {
        fecthNowpokemons(withDelay: 0)
    }
    func reloadPokemons() {
        currentPage = ""
        fecthNowpokemons(withDelay: 3)
    }
    private func getPromise(url: String)->Promise<PokemonResult>{
        if url.isEmpty {
            return PokemonDetailService.getPokemonList(limit: limit, offset:0)
        }
        return PokemonDetailService.getPokemonList(url: url)
    }
    private func fecthNowpokemons(withDelay delay: TimeInterval){
        currentPromise = getPromise(url: currentPage)
        currentPromise?.then(on: .global(), { (pokes) -> [Pokemon] in
            self.currentPage = pokes.next ?? ""
            let urls = pokes.results?.map({$0.url}) ?? [String]()
            return urls.compactMap({try? await(PokemonDetailService.getPokemon(url: $0))})
        }).then(on: .main, { (pokes) in
            let pokemonList = pokes.map { (p) -> Pokemon in
                var pokemon = p
                pokemon.name = pokemon.name?.capitalized
                pokemon.coverImage = "\(NetworkService.imageHost)\(p.id).png"
                pokemon.frontImage = p.sprites?.frontDefault
                pokemon.url = "\(NetworkService._baseUrl)\(p.id)"
                return pokemon
            }
            
            if self.currentPage == ""{
                self.pokemons = [Pokemon]()
                self.pokemons = pokemonList
                self.presenter?.pokemonsReseted(pokemons: self.pokemons)
            }else{
                self.pokemons += pokemonList
                self.presenter?.pokemonsFetchedSuccess(pokemons: self.pokemons)
            }
        })
        .catch { (error) in
            if let error = error as? APIServiceError{
                self.presenter?.pokemonsFetchFailed(error: error.message ?? "")
            }
            else{
                self.presenter?.pokemonsFetchCanceled()
            }
        }
    }
    func cancelFetch(){
        guard currentPromise != nil else{
            return
        }
        currentPromise?.reject(ErrorType.canceled)
        currentPromise = nil
    }
}
