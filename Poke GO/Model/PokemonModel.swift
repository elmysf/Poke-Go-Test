//
//  PokemonModel.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation

struct PokemonModel: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let types: [String]
    var hp: Int = 0
    var attack: Int = 0
    var defense: Int = 0
    var specialAttack: Int = 0
    var specialDefense: Int = 0
    var speed: Int = 0
    let sprite: URL
    let shinySprite: URL
    
    enum PokemonKeys: String, CodingKey {
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionaryKeys: String, CodingKey {
            case type
            
            enum Typekeys: String, CodingKey {
                case name
            }
        }
        
        enum StatsDictionaryKeys: String, CodingKey {
            case value = "base_stat"
            case stat
            
            enum StatKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_default"
            case shinySprite = "front_shiny"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var decodedTypes: [String] = []
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        while !typesContainer.isAtEnd {
            let typeDictionaryContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictionaryKeys.self)
            let typeContainer = try typeDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictionaryKeys.Typekeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            decodedTypes.append(type)
        }
        
        let types = PokemonModel.organizedTypes(types: decodedTypes)
        self.types = types
        
        var statsContainer = try container.nestedUnkeyedContainer(forKey: .stats)
        while !statsContainer.isAtEnd {
            let statsDictionaryContainer = try statsContainer.nestedContainer(keyedBy: PokemonKeys.StatsDictionaryKeys.self)
            let statContainer = try statsDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.StatsDictionaryKeys.StatKeys.self, forKey: .stat)
            
            switch try statContainer.decode(String.self, forKey: .name) {
            case "hp":
                hp = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "attack":
                attack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "defense":
                defense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "special-attack":
                specialAttack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "special-defense":
                specialDefense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "speed":
                speed = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            default:
                debugPrint("Problems happended")
            }
        }
        
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
        sprite = try spriteContainer.decode(URL.self, forKey: .sprite)
        shinySprite = try spriteContainer.decode(URL.self, forKey: .shinySprite)
    }
    
    init(
        id: Int,
        name: String,
        types: [String],
        hp: Int,
        attack: Int,
        defense: Int,
        specialAttack: Int,
        specialDefense: Int,
        speed: Int,
        sprite: URL,
        shinySprite: URL
    ) {
        self.id = id
        self.name = name
        self.types = types
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.specialAttack = specialAttack
        self.specialDefense = specialDefense
        self.speed = speed
        self.sprite = sprite
        self.shinySprite = shinySprite
    }
    
    static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.types == rhs.types
        && lhs.hp == rhs.hp
        && lhs.attack == rhs.attack
        && lhs.defense == rhs.defense
        && lhs.specialAttack == rhs.specialAttack
        && lhs.specialDefense == rhs.specialDefense
        && lhs.speed == rhs.speed
        && lhs.sprite == rhs.sprite
        && lhs.shinySprite == rhs.shinySprite
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(types)
        hasher.combine(hp)
        hasher.combine(attack)
        hasher.combine(defense)
        hasher.combine(specialAttack)
        hasher.combine(specialDefense)
        hasher.combine(speed)
        hasher.combine(sprite)
        hasher.combine(shinySprite)
    }
    
    static func makeTempPokemon() -> PokemonModel {
        PokemonModel(
            id: 1,
            name: "bulbasaur",
            types: ["grass", "poison"],
            hp: 45,
            attack: 49,
            defense: 49,
            specialAttack: 65,
            specialDefense: 65,
            speed: 45,
            sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!,
            shinySprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")!
        )
    }
}

enum Type: String, Decodable {
    case poison
    case fire
    case water
    case flying
}
