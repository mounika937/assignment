//
//  WrapTags.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI

struct WrapTags: View {
    let tags: [String]
    var body: some View {
        FlexibleView(data: tags, spacing: 8, alignment: .leading) { tag in
            Text(tag)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
        }
    }
}
