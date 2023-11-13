//
//  ContentView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: PokemonViewModel
    @AppStorage("showWelcome") var showWelcome: Bool = true
    @State var selection: Int = 0
    
    var body: some View {
        ZStack{
            // Your native TabView here
            TabView(selection: $selection) {
                switch viewModel.status {
                case .fetching where viewModel.pokemon.count == 0:
                    ProgressIndicatorView()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.mint)
                case .failed(let error) where viewModel.pokemon.count == 0:
                    ErrorView(error: error.localizedDescription)
                case .success, .fetching, .failed(_):
                    PokemonListView(viewModel: self.viewModel).tag(0)
                case .favorite:
                    PokemonFavoriteView().tag(1)
                case .notStarted:
                    Text("Not fetching yet")
                }
            }
            .overlay( // Overlay the custom TabView component here
                Color.gray // Base color for Tab Bar
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(height: 50) // Match Height of native bar
                    .opacity(0.2)
                    .overlay(HStack {
                        Spacer()
                        
                        // First Tab Button
                        Button(action: {
                            self.selection = 0
                        }, label: {
                            Image("PokemonListInActive")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == 0 ? 1 : 0.4)
                        })
                        Spacer()
                        
                        // Second Tab Button
                        Button(action: {
                            self.selection = 1
                        }, label: {
                            Image("FavInactive")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == 1 ? 1 : 0.4)
                        })
                        Spacer()
                        
                    }),alignment: .bottom) // Align the overlay to bottom to ensure tab bar stays pinned.
        }
        .fullScreenCover(isPresented: $showWelcome) {
            WelcomeView(showWelcome: $showWelcome)
        }

    }
}

#Preview {
    return ContentView(viewModel: PokemonViewModel(pokemonService: PokemonService()))
}
