//
//  Video.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}

struct VideoResponse: Codable {
    let results: [Video]
}
