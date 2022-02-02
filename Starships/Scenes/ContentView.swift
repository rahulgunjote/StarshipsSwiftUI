//
//  ContentView.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = StarshipViewModel(
        apiService: StarshipAPIService())

    enum TabItem: String {
        case starships, favorites
    }

    var body: some View {
        TabView {
            starships.environmentObject(viewModel)
            favorites.environmentObject(viewModel)
        }
    }

    var starships: some View {
        NavigationView {
            StarshipHomeView()
                .navigationTitle("Starships")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Image(systemName: "star")
            Text("Starships")
        }
        .tag(TabItem.starships)
    }

    var favorites: some View {
        NavigationView {
            FavoritesStarshipsView()
                .navigationTitle("Favorites")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Image(systemName: "heart")
            Text("Favorites")
        }
        .tag(TabItem.favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

