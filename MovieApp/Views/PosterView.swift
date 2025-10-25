//
//  PosterView.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI

struct PosterView: View {
    let path: String?
    var width: CGFloat = 100
    var height: CGFloat = 150
    
    var body: some View {
        ZStack {
            if let p = path, let url = URL(string: TMDb.imageBase + "w300" + p) {
                AsyncImage(url: url) { img in img.resizable().scaledToFill() } placeholder: { Color.gray.opacity(0.2) }
            } else { Color.gray.opacity(0.2) }
        }
        .frame(width: width, height: height)
        .clipped()
        .cornerRadius(10)
    }
}
