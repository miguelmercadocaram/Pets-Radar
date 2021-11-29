//
//  AuthResponse.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/28/21.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let token_type: String
    
}
