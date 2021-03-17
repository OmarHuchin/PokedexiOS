//
//  MovieDetailService.swift
// Pokedex
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Promises

enum PokemonServiceRouter: INetworkRouter{
    case getPokemonList(limit:Int,offset:Int)
    case getPokemons(url:String)
    case getPokemon(url:String)
    case getPokemonById(id:Int)
    var path: String{
        switch self {
            
        case .getPokemonList:
            return "pokemon"
        case .getPokemons(_):
            return ""
        case .getPokemon(url: let url):
            return ""
        case .getPokemonById(id: let id):
            return "pokemon/\(id)"
        }
    }
    
    var method: HttpMethod{
        return .get
    }
    
    var task: NetworkTask{
        switch self{
        case .getPokemonList(let limit, let offset):
            return .requestParameters(parameters: [
                "limit": limit,
                "offset":offset
            ])
        case .getPokemons( _):
            return .requestPlain
        case .getPokemon(url: let url):
            return .requestPlain
        case .getPokemonById(id: let id):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    var baseURL: URL? {
        switch self {
        case .getPokemonById(id: let id):
        return nil
        case .getPokemonList:
            return nil
        case .getPokemons(url: let url):
            return URL(string: url)
        case .getPokemon(url: let url):
            return URL(string: url)
        }
    }
}
struct PokemonDetailService{
    static func getPokemonList(limit: Int, offset:Int) -> Promise<PokemonResult> {
        return NetworkService.shared.request(PokemonServiceRouter.getPokemonList(limit: limit, offset: offset), type: PokemonResult.self)
    }
    
    static func getPokemonList(url:String) -> Promise<PokemonResult> {
        return NetworkService.shared.request(PokemonServiceRouter.getPokemons(url: url), type: PokemonResult.self)
    }
    static func getPokemon(url:String) -> Promise<Pokemon> {
        return NetworkService.shared.request(PokemonServiceRouter.getPokemon(url: url), type: Pokemon.self)
    }
    static func getPokemon(id:Int) -> Promise<Pokemon> {
        return NetworkService.shared.request(PokemonServiceRouter.getPokemonById(id: id), type: Pokemon.self)
    }
}
