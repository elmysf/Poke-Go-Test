//
//  PokemonRowCell.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI

struct PokemonRowCell: View {
    let pokemon: PokemonModel

    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(self.pokemon.name.capitalized).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                    .padding(.leading)
                Spacer()

                HStack(spacing: 0){
                    VStack{
                        if pokemon.types.count > 0 {
                            ForEach(pokemon.types, id: \.self) { type in
                                Text(type.capitalized)
                                    .font(.system(size: 10,weight: .regular, design: .rounded))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(Color.purple.cornerRadius(radius: 126, corners: [.allCorners]))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }

                    AsyncImage(url: pokemon.sprite) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }.padding(.top, 4)
        }
        .background(Color(pokemon.background))
        .cornerRadius(12)
        .frame(width: 180, height: 110)
    }
}

#Preview {
    return PokemonRowCell(pokemon: PokemonModel.makeTempPokemon())
}
