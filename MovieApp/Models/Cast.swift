//
//  Cast.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation

struct Cast: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String?
    let profile_path: String?
}

struct CreditsResponse: Codable {
    let cast: [Cast]
}
