//
//  StarshipViewModel.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation
import Combine

class StarshipViewModel: ObservableObject {
    
    private let apiService: StarshipAPIService
    
    @Published var dataResponse: StarshipResponse?
    @Published var dataResults: [Starship] = []
    @Published var noResultsFound = false
    @Published var showErrorAlert = false
    @Published var isLoadingMore  = false
    @Published var isFetchingInitialResults = false
   
    @Published private var sortOption: StarshipSortOption = .nameAscending


    private var subscriptions = Set<AnyCancellable>()
    private var requestSubscription: AnyCancellable?
    private var resultIds: [String: String] = [:]

    var errorMessage: String?
    
    init(apiService: StarshipAPIService ) {
        self.apiService = apiService
        loadData()
    }
    func loadData() {
        resetSearch()
        sendRequest()
    }

    func loadMore() {
        isLoadingMore = true
        sendLoadMoreRequest()
    }
}

extension StarshipViewModel {
    
    private func sendRequest() {
        
        if dataResults.count == 0 {
            isFetchingInitialResults = true
        }
        
        requestSubscription = apiService.apiPublisher()
            .sink { [weak self] completion in
                self?.isFetchingInitialResults = false
                if case .failure(let error) = completion {
                    self?.handleSearchError(error)
                }
            } receiveValue: { [weak self] apiResponse in
                self?.handleSearchResults(apiResponse)
            }
    }
    
    private func sendLoadMoreRequest() {
        
        guard let nextUrlString = dataResponse?.next,
              let nextURL = URL(string: nextUrlString) else {
                  return
              }
        
        requestSubscription = apiService.apiPublisher(with: nextURL)
            .sink { [weak self] completion in
                self?.isFetchingInitialResults = false
                if case .failure(let error) = completion {
                    self?.handleSearchError(error)
                }
            } receiveValue: { [weak self] apiResponse in
                self?.handleSearchResults(apiResponse)
            }
    }


    private func handleSearchResults(_ apiResponse: StarshipResponse) {
        
        dataResponse = apiResponse
        
        guard let results = apiResponse.results,
                  results.count > 0 else {
            if isLoadingMore {
                stopLoadingMore()
            } else {
                noResultsFound = true
            }
            return
        }
        if isLoadingMore {
            stopLoadingMore()
        }
        var newResults: [Starship] = []

        for item in results where resultIds[item.id] != item.id {
            resultIds[item.id] = item.id
            newResults.append(item)
        }
        guard newResults.count > 0 else {
            return
        }
        newResults.sortBy(option: self.sortOption)
        dataResults += newResults
    }

    private func handleSearchError(_ error: Error) {
        errorMessage = error.localizedDescription
        showErrorAlert = true
        isLoadingMore = false
        // allow user to retry the same search due to the error
    }

    private func resetSearch() {
        dataResults = []
        resultIds = [:]
        noResultsFound = false
        errorMessage = nil
        isLoadingMore = false
    }

    private func stopLoadingMore() {
        isLoadingMore = false
    }
    
    func sortStarships(sortOption: StarshipSortOption) {
        if self.sortOption == sortOption {
            return
        }
        self.sortOption = sortOption
        self.dataResults.sortBy(option: sortOption)
    }
}


