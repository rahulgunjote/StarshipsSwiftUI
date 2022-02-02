//
//  StarshipHomeView.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import SwiftUI

struct StarshipHomeView: View {
    
    @EnvironmentObject var viewModel: StarshipViewModel

    var body: some View {
        
        VStack(alignment: .leading) {

            ZStack {
                StarshipListView()

                if viewModel.isFetchingInitialResults {
                    VStack {
                       Text("Fetching starships...")
                       ProgressView()
                    }
                }

                if viewModel.noResultsFound {
                    Text("No results found.")
                        .bold()
                }
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            let message = viewModel.errorMessage
            viewModel.errorMessage = nil

            return Alert(
                title: Text("Error"),
                message: Text(message ?? APIError.generic.localizedDescription)
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipHomeView()
    }
}

