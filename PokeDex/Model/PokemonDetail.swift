//
//  PokemonDetail.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
//

import Foundation

struct PokemonDetail: Codable {
    let abilities: [AbilityArray]
    let base_experience: Int
    let height: Int
    let id: Int
    let sprites: Sprite
    let types: [TypeArray]
    let weight: Int
    
}
