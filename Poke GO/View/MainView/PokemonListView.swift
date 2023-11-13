//
//  PokemonListView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonViewModel
    @State var showFilterButtons = false
    @State var filterApplied = false
    @State var AppliedData = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        let dataSource = filterApplied ? viewModel.filteredPokemon : viewModel.pokemon
                        let dataSearch = viewModel.searchResults
                        
                        if !filterApplied {
                            ForEach(dataSearch) { pokemon in
                                NavigationLink(
                                    destination: NavigationLazyView(PokemonDetailView(pokemon: pokemon)),
                                    label: {
                                        PokemonRowCell(pokemon: pokemon)
                                    })
                            }
                        }else{
                            ForEach(dataSource) { pokemon in
                                NavigationLink(
                                    destination: NavigationLazyView(PokemonDetailView(pokemon: pokemon)),
                                    label: {
                                        PokemonRowCell(pokemon: pokemon)
                                    })
                            }
                            
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 36)
                    .padding(.top, 8)
                }
                .navigationBarTitle("Pokemon")
                .searchable(text: $viewModel.searchText)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        Task {
                            await viewModel.getPokemons(offset: viewModel.pokemon.count)
                        }
                    }
                }
                
                VStack {
                    if showFilterButtons {
                        ActionButton(imageName: "fire", backgroundColor: .red, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: ["fire"])
                        }
                        ActionButton(imageName: "leaf", backgroundColor: .green, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: ["poison"])
                            
                        }
                        ActionButton(imageName: "water", backgroundColor: .blue, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: ["water"])
                            
                        }
                        ActionButton(imageName: "lightning", backgroundColor: .yellow, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: ["electric"])
                        }
                    }
                    
                    let imageName = filterApplied ? "refresh" : "filter"
                    ActionButton(imageName: imageName, height: 36, width: 36, show: $showFilterButtons) {
                        filterApplied ? filterApplied.toggle() : showFilterButtons.toggle()
                    }.rotationEffect(.init(degrees: self.showFilterButtons ? 180 : 0))
                    
                }
                .padding()
            }
        }
    }
}
#Preview {
    return PokemonListView(viewModel: PokemonViewModel(pokemonService: PokemonService()))
}
