//
//  PokemonDetailView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    var pokemon: PokemonModel
    @State var showShiny = false
    
    let pokemon: PokemonModel
    let viewModel: PokemonRowViewModel

    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
        self.viewModel = PokemonRowViewModel(pokemon: pokemon)
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

                Color.white.offset(y: 300)

            ScrollView {
                KFImage(URL(string: pokemon.imageUrl))
                    .resizable()
                    .frame(width: 200, height: 200)

                VStack(alignment: .leading) {
                    Text(pokemon.name.capitalized)
                        .font(.system(size: 40,weight: .bold, design: .rounded))
                        .padding(.top, 40)
                        .frame(maxWidth: .infinity, alignment: .center)

                    HStack(spacing: -200){
                        Text(pokemon.type.capitalized)
                            .font(.system(size: 18,weight: .regular, design: .rounded))
                            .foregroundColor(Color.white)
                            .padding(.all, 8)
                            .background(Color.purple.cornerRadius(radius: 126, corners: [.allCorners]))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text(pokemon.typeDefault.capitalized)
                            .font(.system(size: 18,weight: .regular, design: .rounded))
                            .foregroundColor(Color.white)
                            .padding(.all, 8)
                            .background(Color.green.cornerRadius(radius: 126, corners: [.allCorners]))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Text(pokemon.description)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    
                    
                    VStack(alignment: .leading){
                            Text("Stats")
                                .font(.system(size: 16, weight: .semibold))
                        
                        BarChartView(pokemon: pokemon)
                            .padding(.leading, -32)
                            .padding(.trailing, 32)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
                }
                .background(Color.white.cornerRadius(radius: 40, corners: [.topLeft, .topRight]))
                .padding(.top, -80)
            }
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: SAMPLE_POKEMON)
    }
}
