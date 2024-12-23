//
//  PeopleDetailViewModel.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation
import Combine

class PeopleDetailViewModel: ObservableObject {
    @Published var person: PeopleDetails?
    @Published var images: [ProfileImage] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPersonDetails(personId: Int) {
        let detailsUrl = URL(string: "\(APIConfig.baseURL)/person/\(personId)?api_key=\(APIConfig.apiKey)")!
        
        NetworkManager.shared.fetch(url: detailsUrl)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    print("Error is..\(completion)")
                }
            }, receiveValue: { [weak self] (person: PeopleDetails) in
                self?.person = person
            })
            .store(in: &cancellables)
    }
    
    func fetchGallery(personId: Int) {
        let imagesUrl = URL(string: "\(APIConfig.baseURL)/person/\(personId)/images?api_key=\(APIConfig.apiKey)")!
        NetworkManager.shared.fetch(url: imagesUrl)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching gallery: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (response: PeopleImagesResponse) in
                self?.images = response.profiles
            })
            .store(in: &cancellables)
    }
}
