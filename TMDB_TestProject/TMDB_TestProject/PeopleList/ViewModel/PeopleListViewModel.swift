//
//  PeopleListViewModel.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation
import Combine

// PeopleListViewModel
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
    
    func fetchPeople() {
        guard !isLoading && canLoadMorePages else { return }
        isLoading = true
        
        let query = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = searchQuery.isEmpty ?
            "https://api.themoviedb.org/3/person/popular?api_key=\(APIConfig.apiKey)&page=\(currentPage)" :
            "https://api.themoviedb.org/3/search/person?api_key=\(APIConfig.apiKey)&query=\(query)&page=\(currentPage)"
        
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
    
    private func resetSearch() {
        people = []
        currentPage = 1
        canLoadMorePages = true
    }
}
