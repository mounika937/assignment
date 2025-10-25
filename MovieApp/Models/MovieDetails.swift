//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
    let vote_average: Double
    let genres: [Genre]
}


