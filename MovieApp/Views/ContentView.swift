//
//  ContentView.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MovieListViewModel()
    @EnvironmentObject var favs: FavoritesStore
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading && vm.movies.isEmpty {
                    ProgressView("Loading…")
                } else if let err = vm.error { Text(err).foregroundColor(.red) }
                else { movieList }
            }
#if os(iOS)
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search movies")
#else
            .searchable(text: $vm.searchText, prompt: "Search movies")
#endif
            .onChange(of: vm.searchText) { _, _ in Task { await vm.performSearch() } }
            .task { await vm.load() }
        }
    }
    
    private var movieList: some View {
        List(vm.movies) { movie in
            NavigationLink(value: movie) { MovieRow(movie: movie) }
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailView(movie: movie)
        }
        .listStyle(.plain)
    }
}
