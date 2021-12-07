//
//  Breeds.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 12/7/21.
//

import Foundation

struct Breedss: Codable {
    let breeds: [Breeds]
}

struct Breeds: Codable {
    let name: String
}
