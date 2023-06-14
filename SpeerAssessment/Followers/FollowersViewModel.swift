//
//  FollowersViewModel.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 3:22 pm mst

import Foundation
import Combine

class FollowersViewModel: ObservableObject {
    @Published var usernames: [String]? // Array of usernames of the followers
    @Published var isLoading = false // Flag indicating whether the data is being loaded
        
    private let apiService: ApiManager // Instance of the ApiManager for fetching data
    private var cancellables = Set<AnyCancellable>() // Set to store the cancellables
    
    init(apiService: ApiManager = ApiManager()) {
        self.apiService = apiService
    }
    
    /**
     Fetch following info in ViewModel
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchFollowers(username: String) {
        isLoading = true
        
        apiService.fetchFollowers(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false// Set isLoading to false when fetching data completes
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Followers API: receive error: \(error)")
                }//
            }, receiveValue: { [weak self] followers in
                guard let self = self else { return }
                
                self.usernames = followers.map { $0.login }// Extract the usernames from the followers
            })
            .store(in: &cancellables)// Store the cancellable in the set
    }//fetchFollowers
}//FollowersViewModel
