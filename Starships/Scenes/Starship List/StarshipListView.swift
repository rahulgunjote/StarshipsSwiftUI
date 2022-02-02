//
//  StarshipListView.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import SwiftUI

struct StarshipListView: View {
    
    @EnvironmentObject var viewModel: StarshipViewModel
    
    @State private var showingOptions = false
    @State private var selection = "None"
    
    var body: some View {
        
        VStack {
            if viewModel.dataResults.count > 0 {
                HStack(spacing: 10) {
                    Spacer()
                    Button("Sort By") {
                        showingOptions = true
                    }
                    .padding(.trailing, 20)
                    .actionSheet(isPresented: $showingOptions) {
                        ActionSheet(
                            title: Text("Sort By"),
                            buttons: [
                                .default(Text("Name Ascending")) {
                                    viewModel.sortStarships(sortOption: .nameAscending)
                                },
                                .default(Text("Name Descending")) {
                                    viewModel.sortStarships(sortOption: .nameDescending)
                                },
                                .default(Text("Length Ascending")) {
                                    viewModel.sortStarships(sortOption: .lengthAscending)
                                },
                                .default(Text("Length Descending")) {
                                    //selection = "Green"
                                    viewModel.sortStarships(sortOption: .lengthDescending)
                                }
                            ]
                        )
                    }
                }
            }
            List {
                Section {
                    ForEach($viewModel.dataResults) { $item in
                        StarshipListRow(starship: $item)
                    }
                    
                }  footer: {
                    if viewModel.dataResults.count > 0 {
                        Button {
                            viewModel.loadMore()
                        } label: {
                            if viewModel.isLoadingMore {
                                HStack {
                                    Spacer()
                                    ProgressView("Loading...")
                                        .padding([.top, .bottom], 10)
                                    Spacer()
                                }
                            }else {
                                Text("Load more")
                            }
                        }
                    }
                    else {
                        EmptyView()
                    }
                }
            }
        }
        
    }
}

struct SearchListView_Previews: PreviewProvider {
    static let viewModel: StarshipViewModel = {
        let viewModel = StarshipViewModel(apiService: StarshipAPIService())
        viewModel.dataResults = Starship.sampleData
        return viewModel
    }()
    
    static var previews: some View {
        StarshipListView().environmentObject(viewModel)
    }
}

