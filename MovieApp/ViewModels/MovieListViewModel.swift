//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation
@MainActor final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var error: String?
    
    func load() async { await fetchPopular() }
    
    func fetchPopular() async {
        isLoading = true; defer { isLoading = false }
        do { movies = try await TMDbService.shared.popular() } catch { self.error = error.localizedDescription }
    }
    
    func performSearch() async {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { await fetchPopular(); return }
        isLoading = true; defer { isLoading = false }
        do { movies = try await TMDbService.shared.search(query: q) } catch { self.error = error.localizedDescription }
    }
}
