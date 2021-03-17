//
//  Presenter.swift
// Pokedex
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
class PokemonPresenter: PokemonViewToPresenterProtocol {
    var view: PokemonsCollectionViewController?
    var interactor: PokemonPresenterToInteractorProtocol?
    var router:PokemonPresenterToRouterProtocol?
    var isLoading: Bool = false
    
    func showNowMovies() {
        interactor?.fetchPokemons()
    }
    func didSelect(indexPath: IndexPath) {
        interactor?.getPokemon(byIndex: indexPath.item)
    }
    func didScroll(scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if isLoading{
            var contentTop = scrollView.contentInset.top + scrollView.contentOffset.y
            contentTop *= -1
            if contentTop > 70{
                contentTop = 70
            }
            if contentTop < -10 && (contentOffsetY < scrollView.contentSize.height / 2){
                interactor?.cancelFetch()
                contentTop = 0
            }
        }
        if !isLoading, scrollView.contentSize.height > CGSize.zero.height, contentOffsetY >= ((scrollView.contentSize.height - scrollView.bounds.height) - 20){
            isLoading = true
            interactor?.fetchMorePokemons()
        }
        if !isLoading, contentOffsetY <= -100{
            isLoading = true
            view?.displayLoading()
            interactor?.reloadPokemons()
        }
    }
    func getSizeItem(collectionView: UICollectionView) -> CGSize {
        let edgeInsets = getEdgeInsets(collectionView: collectionView)
        let size = CGSize(width: (collectionView.bounds.size.width * 0.5) - (edgeInsets.left + (edgeInsets.left / 2)), height: collectionView.bounds.size.height * 0.4)
        return size
    }
    func getEdgeInsets(collectionView: UICollectionView)->UIEdgeInsets{
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func getMinimumInteritemSpacingForSectionAt(collectionView: UICollectionView) -> CGFloat {
        return 0
    }
    func getMinimumLineSpacingForSectionAt(collectionView: UICollectionView) -> CGFloat {
        return 8
    }
}
extension PokemonPresenter: PokemonInteractorToPresenterProtocol{
    func pokemonsReseted(pokemons: [Pokemon]) {
        isLoading = false
        view?.hideLoading()
        view?.display(pokemons: pokemons)
    }
    func pokemonSelected(pokemon: Pokemon) {
        router?.pushToDetailPokemonScreen(pokemon: pokemon)
    }
    func pokemonsFetchedSuccess(pokemons: [Pokemon]) {
        isLoading = false
        view?.display(pokemons: pokemons)
    }
    func pokemonsFetchFailed(error: String) {
        isLoading = false
        view?.display(error: error)
    }
    func pokemonsFetchCanceled() {
        isLoading = false
        view?.hideLoading()
    }
}
