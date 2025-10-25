//
//  Movie.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let vote_average: Double
    let release_date: String?
}

struct MovieResponse: Codable {
    let results: [Movie]
}
