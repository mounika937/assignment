import SwiftUI

@main
struct MovieAppApp: App {
    @StateObject private var favs = FavoritesStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favs)
        }
    }
}
