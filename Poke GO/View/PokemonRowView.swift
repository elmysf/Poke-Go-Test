//
//  PokemonRowView.swift
//  Dex3
//
//  Created by Sufiandy Elmy on 12/11/23.
//

import SwiftUI

struct PokemonRowView: View {
    var pokemon: TempPokemon
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(self.pokemon.name.capitalized).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                    .padding(.leading)
                Spacer()

                HStack {
                    if pokemon.types.count > 0 {
                        ForEach(pokemon.types, id: \.self) { type in
                            Text(type.capitalized)
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white.opacity(0.25)))
                                    .frame(width: 100, height: 24)

                        }
                    }
   
                    AsyncImage(url: pokemon.sprite) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: UIScreen.main.bounds.width / 6.5)
                    .shadow(color: .white, radius: 5)
                }
            }.padding(.top, 4)
        }
        .background(Color.mint)
        .cornerRadius(12)
    }
}

#Preview {
    PokemonRowView(pokemon: TempPokemon.makeTempPokemon())
}
