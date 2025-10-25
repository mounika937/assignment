//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation
@MainActor final class MovieDetailViewModel: ObservableObject {
    @Published var details: MovieDetails?
    @Published var cast: [Cast] = []
    @Published var trailer: Video?
    @Published var isLoading = false
    @Published var error: String?
    
    let movie: Movie
    init(movie: Movie) { self.movie = movie }
    
    func load() async {
        isLoading = true; defer { isLoading = false }
        do {
            async let d = TMDbService.shared.details(for: movie.id)
            async let v = TMDbService.shared.videos(for: movie.id)
            async let c = TMDbService.shared.credits(for: movie.id)
            let (details, videos, cast) = try await (d, v, c)
            self.details = details
            self.cast = Array(cast.prefix(15))

            let yt = videos.filter { $0.site.lowercased() == "youtube" }
            let trailerTypes = ["trailer", "teaser"]

            self.trailer =
                yt.first { trailerTypes.contains($0.type.lowercased()) && $0.name.localizedCaseInsensitiveContains("official") } ??
                yt.first { trailerTypes.contains($0.type.lowercased()) } ??
                yt.first ??
                videos.first
        } catch { self.error = error.localizedDescription }
    }
}
