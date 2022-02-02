//
//  StarshipListRow.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import SwiftUI

struct StarshipListRow: View {
    @Binding var starship: Starship
    
    var body: some View {
        NavigationLink {
            StarshipDetailView(starship: $starship)
        } label: {
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text(starship.name)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    
                    Text(starship.manufacturer ?? "")
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    Text("Length: \(starship.length ?? "")")
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    
                }
                Spacer()
                FavoriteButton(isSet: $starship.isFavorite)

            }.padding()
            
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}

struct SearchListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        StarshipListRow(starship: Binding.constant(Starship.sampleData[0]))
    }
}

