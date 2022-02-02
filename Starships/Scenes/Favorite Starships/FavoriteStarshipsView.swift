//
//  FavoriteStarshipsView.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import SwiftUI

struct FavoritesStarshipsView: View {
    
    @EnvironmentObject var viewModel: StarshipViewModel
    
    var favoriteStarships: [Starship] {
        viewModel.dataResults.filter { starship in
            starship.isFavorite
        }
    }
    
    var body: some View {
        if favoriteStarships.count > 0 {
             List {
                Section {
                    ForEach(favoriteStarships) { item in
                        StarshipListRow(starship: makeBinding(item: item))
                    }
                }
            }
        }else {
             Text("Looks like you do not have favorite starship")
        }
    }
    
    func makeBinding(item: Starship) -> Binding<Starship> {
        let i = self.viewModel.dataResults.firstIndex { $0.id == item.id }!
        return .init(
            get: { self.viewModel.dataResults[i] },
            set: { self.viewModel.dataResults[i] = $0 }
        )
    }
}

struct FavoritesStarshipsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesStarshipsView()
    }
}
