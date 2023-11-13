//
//  BarView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI

struct BarView: View {
    var value: Int = 100
    var title: String = "HP"
    var color: Color = .blue

    var body: some View {

        HStack {
            Text(title)
                .padding(.leading, 32)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)

            HStack {
                Text("\(value)")
                    .frame(width: 40)

                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(width: 180, height: 20).animation(.default)
                        .foregroundColor(Color(.systemGray5))

                    Capsule()
                        .frame(width: value > 250 ? CGFloat(200) : CGFloat(value), height: 20).animation(.default)
                        .foregroundColor(color)
                }
            }
        }
    }
}

struct BarChartView: View {
    let pokemon: PokemonModel
    var body: some View {
        VStack {
            BarView(value: pokemon.height, title: "HP", color: .orange)
            BarView(value: pokemon.attack, title: "Attack", color: .red)
            BarView(value: pokemon.defense, title: "Defense", color: .blue)
            BarView(value: pokemon.weight, title: "Special Attack", color: .purple)
            BarView(value: pokemon.speed, title: "Special Defense", color: .green)
            BarView(value: pokemon.speed, title: "Speed", color: .mint)
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView()
        BarChartView(pokemon: SAMPLE_POKEMON)
    }
}



