//
//  TMDbService.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation

enum TMDb {
    static let apiKey = "93540f515966d8a3d07bdfb4ea65948b"
    static let baseURL = URL(string: "https://api.themoviedb.org/3")!
    static let imageBase = "https://image.tmdb.org/t/p/"
}

final class TMDbService {
    static let shared = TMDbService(); private init() {}
    
    private func request(path: String, query: [URLQueryItem] = []) async throws -> Data {
        var components = URLComponents(url: TMDb.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        var items = query; items.append(URLQueryItem(name: "api_key", value: TMDb.apiKey))
        components.queryItems = items
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else { throw URLError(.badServerResponse) }
        return data
    }
    
    func popular() async throws -> [Movie] {
        let data = try await request(path: "movie/popular")
        return try JSONDecoder().decode(MovieResponse.self, from: data).results
    }
    
    func search(query: String) async throws -> [Movie] {
        let data = try await request(path: "search/movie", query: [URLQueryItem(name: "query", value: query)])
        return try JSONDecoder().decode(MovieResponse.self, from: data).results
    }
    
    func details(for id: Int) async throws -> MovieDetails {
        let data = try await request(path: "movie/\(id)")
        return try JSONDecoder().decode(MovieDetails.self, from: data)
    }
    
    func videos(for id: Int) async throws -> [Video] {
        let data = try await request(path: "movie/\(id)/videos")
        return try JSONDecoder().decode(VideoResponse.self, from: data).results
    }
    
    func credits(for id: Int) async throws -> [Cast] {
        let data = try await request(path: "movie/\(id)/credits")
        return try JSONDecoder().decode(CreditsResponse.self, from: data).cast
    }
}
