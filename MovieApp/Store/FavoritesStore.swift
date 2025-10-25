//
//  FavoritesStore.swift
//  MovieApp
//
//  Created by Mounika on 25/10/25.
//

import Foundation
import Combine

final class FavoritesStore: ObservableObject {
    @Published private(set) var ids: Set<Int> = []
    private let key = "fav_ids"
    
    init() {
        if let raw = UserDefaults.standard.array(forKey: key) as? [Int] { ids = Set(raw) }
    }
    
    func toggle(_ id: Int) {
        if ids.contains(id) { ids.remove(id) } else { ids.insert(id) }
        UserDefaults.standard.set(Array(ids), forKey: key)
        objectWillChange.send()
    }
    
    func isFav(_ id: Int) -> Bool { ids.contains(id) }
}
