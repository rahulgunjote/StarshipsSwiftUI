//
//  StarshipDetailView.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import SwiftUI

struct StarshipDetailView: View {
    
    @Binding var starship: Starship
    
    
    var body: some View {
        List {
            Section {
                ForEach(starship.displayProperties) { property in
                    HStack {
                        Text(property.name)
                        Spacer()
                        Text(property.value)
                    }
                }
                
            }
        }
        .navigationTitle(starship.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:FavoriteButton(isSet: $starship.isFavorite))
    }
}

struct StarshipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipDetailView(starship: Binding.constant(Starship.sampleData[0]))
    }
}
