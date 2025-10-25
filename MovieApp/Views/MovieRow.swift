//
//  MovieRow.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    @EnvironmentObject var favs: FavoritesStore
    @State private var runtimeText: String = "—"
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            PosterView(path: movie.poster_path, width: 80, height: 120)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(movie.title).font(.headline).lineLimit(2)
                    Spacer()
                    Button { favs.toggle(movie.id) } label: {
                        Image(systemName: favs.isFav(movie.id) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }.buttonStyle(.plain)
                }
                HStack(spacing: 10) {
                    Label(formatMinutes(runtimeText), systemImage: "clock")
                    Label(String(format: "%.1f", movie.vote_average), systemImage: "star.fill")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                Text(movie.overview).font(.footnote).lineLimit(3).foregroundColor(.secondary)
            }
        }
        .task { await loadRuntime() }
    }
    
    private func loadRuntime() async {
        do {
            let details = try await TMDbService.shared.details(for: movie.id)
            if let rt = details.runtime { runtimeText = "\(rt)" }
        } catch { runtimeText = "—" }
    }
    
    private func formatMinutes(_ text: String) -> String {
        guard let m = Int(text) else { return text }
        let h = m / 60, r = m % 60
        return h > 0 ? "\(h)h \(r)m" : "\(m)m"
    }
}
