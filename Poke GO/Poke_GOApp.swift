//
//  Poke_GOApp.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI

@main
struct Poke_GOApp: App {
    @StateObject var viewModel = PokemonViewModel(pokemonService: PokemonService())

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: self.viewModel)
        }
    }
}
