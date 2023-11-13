//
//  PokemonDetailView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PokemonModel
    @State var showShiny = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(pokemon.background)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

                Color.white.offset(y: 300)

            ScrollView {
                AsyncImage(url: showShiny ? pokemon.shinySprite : pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .zIndex(1)
                } placeholder: {
                    ProgressIndicatorView()
                }

                VStack(alignment: .leading) {
                    Text(pokemon.name.capitalized)
                        .font(.system(size: 40,weight: .bold, design: .rounded))
                        .padding(.top, 40)
                        .frame(maxWidth: .infinity, alignment: .center)

                    
                    Text("Types")
                        .font(.system(size: 18,weight: .regular, design: .rounded))
                        .padding(.bottom, -5)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                        HStack(spacing: -150){
                            if pokemon.types.count > 0 {
                                ForEach(pokemon.types, id: \.self) { type in
                                    Text(type.capitalized)
                                        .font(.system(size: 18,weight: .regular, design: .rounded))
                                        .foregroundColor(Color.white)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(Color(pokemon.background).cornerRadius(radius: 126, corners: [.allCorners]))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        .padding()
                    
                    VStack(alignment: .leading){
                            Text("Stats")
                                .font(.system(size: 16, weight: .semibold))
                        
                        StatsView(pokemon: pokemon)
                            .padding(.leading, -32)
                            .padding(.trailing, 32)
                            .padding(.top, 8)
                        
                        
                        VStack(alignment: .center){
                            Button {
                                showShiny.toggle()
                            } label: {
                                if showShiny {
                                    Image(systemName:"wand.and.stars")
                                } else {
                                    Image(systemName:"wand.and.stars.inverse")
                                        .foregroundStyle(Color.white)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color(pokemon.background))
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 42)
                        }
                        .padding(.top, 32)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
                }
                .background(Color.white.cornerRadius(radius: 48, corners: [.topLeft, .topRight]))
                .padding(.top, -80)
            }
        }
    }
}

