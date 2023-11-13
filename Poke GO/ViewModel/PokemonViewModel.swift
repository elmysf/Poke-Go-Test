//
//  PokemonViewModel.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI



class PokemonViewModel: ObservableObject {
    private let BASE_URL = "https://pokeapi.co/api/v2/pokemon?limit=151"
    
    @Published var pokemon = [PokemonModel]()
    @Published var filteredPokemon = [PokemonModel]()

    func fetchPokemon() {
        guard let url = URL(string: BASE_URL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data?.parseData(removeString: "null,") else { return }
            guard let pokemon = try? JSONDecoder().decode([PokemonModel].self, from: data) else { return }

            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
            print("Its runs ? \(url)")
        }.resume()
    }

    func filterPokemon(by filter: String) {
        filteredPokemon = pokemon.filter({ $0.type == filter })
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
