//
//  FlexibleView.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import SwiftUI

struct FlexibleView<Data: BidirectionalCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    
    var body: some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        return GeometryReader { geo in
            ZStack(alignment: Alignment(horizontal: alignment, vertical: .top)) {
                ForEach(Array(data), id: \.self) { item in
                    content(item)
                        .padding(4)
                        .alignmentGuide(.leading) { d in
                            if abs(width - d.width) > geo.size.width { width = 0; height -= d.height }
                            let result = width
                            if item == data.last { width = 0 } else { width -= d.width }
                            return result
                        }
                        .alignmentGuide(.top) { _ in height }
                }
            }
        }
        .frame(height: CGFloat((data.count / 5) + 1) * 28)
    }
}
