//
//  PeopleListViewModel.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation
import Combine

class PeopleListViewModel: ObservableObject {
    @Published var people: [PeopleData] = []
    @Published var isLoading = false
    @Published var searchQuery = "" {
        didSet {
            resetSearch()
            fetchPeople()
        }
    }
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch people based on search query or popular people list
    func fetchPeople() {
        guard !isLoading && canLoadMorePages else { return }
        isLoading = true
        
        // Determine URL based on whether we're searching or fetching popular people
        let query = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString: String
        if searchQuery.isEmpty {
            // Fetching popular people
            urlString = "https://api.themoviedb.org/3/person/popular?api_key=\(APIConfig.apiKey)&page=\(currentPage)"
        } else {
            // Searching for people
            urlString = "https://api.themoviedb.org/3/search/person?api_key=\(APIConfig.apiKey)&query=\(query)&page=\(currentPage)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetch(url: url)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure = completion {
                    self?.canLoadMorePages = false
                }
            }, receiveValue: { [weak self] (response: PeopleListResponse) in
                self?.people.append(contentsOf: response.results)
                self?.currentPage += 1
                self?.canLoadMorePages = response.page < response.total_pages
            })
            .store(in: &cancellables)
    }
    
    // Reset search and pagination for a new query
    private func resetSearch() {
        people = [] // Clear the existing list of people
        currentPage = 1 // Reset pagination to the first page
        canLoadMorePages = true // Reset the load more condition
    }
}
