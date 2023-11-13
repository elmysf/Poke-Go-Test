//
//  BarView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI
import Charts

struct StatsView: View {
    var pokemon: PokemonModel
    var body: some View {
        VStack {
            BarView(value: pokemon.hp, title: "HP", color: .orange)
            BarView(value: pokemon.attack, title: "Attack", color: .red)
            BarView(value: pokemon.defense, title: "Defense", color: .blue)
            BarView(value: pokemon.specialAttack, title: "S.Attack", color: .purple)
            BarView(value: pokemon.specialDefense, title: "S.Defense", color: .green)
            BarView(value: pokemon.speed, title: "Speed", color: .yellow)
        }
    }
}

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
