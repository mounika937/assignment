//
//  Item.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
