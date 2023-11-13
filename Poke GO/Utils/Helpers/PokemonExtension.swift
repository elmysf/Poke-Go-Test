//
//  PokemonExtension.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 13/11/23.
//

import Foundation
import SwiftUI

extension PokemonModel {
    var background: UIColor {
        switch types[0] {
        case "fire": return .systemRed
        case "poison", "bug": return .systemGreen
        case "water": return .systemTeal
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemBlue
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
    
    static func organizedTypes(types: [String]) -> [String] {
        var tempTypes = types
        if types.count == 2 && types[0] == "normal" {
            tempTypes.swapAt(0, 1)
        }
        
        return tempTypes
    }
}

struct Stat: Identifiable {
    let id: Int
    let label: String
    let value: Int
}
