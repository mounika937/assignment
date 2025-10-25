//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @EnvironmentObject var favs: FavoritesStore
    @StateObject private var vm: MovieDetailViewModel
    
    init(movie: Movie) {
        self.movie = movie
        _vm = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let trailer = vm.trailer {
                    YouTubePlayerView(videoKey: trailer.key).frame(height: 220).cornerRadius(12)
                }
                HStack(alignment: .top, spacing: 12) {
                    PosterView(path: movie.poster_path, width: 110, height: 165)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(vm.details?.title ?? movie.title)
                                .font(.title3).bold().lineLimit(2)
                            Spacer()
                            Button { favs.toggle(movie.id) } label: {
                                Image(systemName: favs.isFav(movie.id) ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                            }.buttonStyle(.plain)
                        }
                        HStack(spacing: 14) {
                            if let rt = vm.details?.runtime { Label(formatMinutes(rt), systemImage: "clock") }
                            Label(String(format: "%.1f", vm.details?.vote_average ?? movie.vote_average), systemImage: "star.fill")
                        }.foregroundColor(.secondary)
                        if let genres = vm.details?.genres, !genres.isEmpty {
                            WrapTags(tags: genres.map { $0.name })
                        }
                    }
                }
                if let overview = vm.details?.overview ?? (movie.overview.isEmpty ? nil : movie.overview) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Plot").font(.headline)
                        Text(overview)
                    }
                }
                if !vm.cast.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cast").font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(vm.cast) { c in
                                    VStack(spacing: 6) {
                                        PosterView(path: c.profile_path, width: 80, height: 110)
                                        Text(c.name).font(.caption).lineLimit(1)
                                        Text(c.character ?? "").font(.caption2).foregroundColor(.secondary).lineLimit(1)
                                    }.frame(width: 80)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .task { await vm.load() }
    }
    
    private func formatMinutes(_ m: Int) -> String {
        let h = m / 60, r = m % 60
        return h > 0 ? "\(h)h \(r)m" : "\(m)m"
    }
}
