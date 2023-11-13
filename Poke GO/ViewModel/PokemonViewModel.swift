//
//  PokemonViewModel.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI

@MainActor
class PokemonViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success
        case favorite
        case failed(error: Error)
    }
    
    private let pokemonService: PokemonService
    private let limit: Int = 40
    
    @Published var filteredPokemon = [PokemonModel]()
    @Published private(set) var pokemon: [PokemonModel] = []
    @Published private(set) var status: Status = .notStarted
    @Published private(set) var favorite: Status = .favorite
    @Published var searchText: String = ""
    @Published var isSearchResultExists: Bool = false
    
    var searchResults: [PokemonModel] {
        guard !searchText.isEmpty else { return pokemon }
        
        return pokemon.filter { pokemon in
            pokemon.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
        Task {
            await getPokemons(offset: 0)
        }
    }
    
    func getPokemons(offset: Int) async {
        status = .fetching
        
        do {
            var tempArray = try await pokemonService.fetchPokemons(
                offset: String(offset),
                limit: String(limit)
            )
            
            tempArray.sort { $0.id < $1.id }
            
            self.pokemon.append(contentsOf: tempArray)
            status = .success
            
            debugPrint("Number of pokemons -> \(pokemon.count)")
        } catch {
            status = .failed(error: error)
            debugPrint("Something went wrong...")
        }
    }
    
    func hasMorePagesToFetch() -> Bool {
        pokemonService.nextPage?.absoluteString.isEmpty == false
    }
    
    func startedSearching() -> Bool {
        searchText.isEmpty == false
    }
    
    func filterPokemon(by filter: [String]) {
        filteredPokemon = pokemon.filter({ $0.types == filter })
    }
}


extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
