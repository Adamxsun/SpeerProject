//
//  UserProfileViewModel.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 2:19 pm mst

import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var user: User? // Published property for storing user profile data
    @Published var isLoading = false // Published property for tracking loading state
    @Published var isUserNotFound = false // Published property for tracking user not found state
    
    private let apiManager = ApiManager() // Instance of the API manager
    private var cancellables: Set<AnyCancellable> = [] // Set to store Combine cancellables
    private let userProfileCache = UserProfileCache() // Instance of the user profile cache
        
    
    /**
     Fetch user profile based on the provided username
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchUserProfile(username: String) {
        isLoading = true
        isUserNotFound = false
        if userProfileCache.isCacheValid() {
            // If the cache is valid, fetch user profile from the cache
            user = userProfileCache.getUserProfile()
            isLoading = false
        }//if
        else
        {   // Otherwise, fetch user profile from the API
            apiManager.fetchUserProfile(username: username)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.isLoading = false
                    
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        self.isUserNotFound = true
                    }
                }, receiveValue: { [weak self] user in
                    guard let self = self else { return }
                    
                    self.user = user
                    self.isLoading = false // Set isLoading to false after receiving the user data
                })
                .store(in: &cancellables)
        }//else
        
    }//fetchUserProfile
    
    /**
     Fetch the number of followers for the given username
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchFollowers(username: String) {
        isLoading = true
        
        apiManager.fetchFollowers(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Followers API: receive error: \(error)")
                }
            }, receiveValue: { [weak self] followers in
                guard let self = self else { return }
                
                if let user = self.user {
                    let updatedUser = User(login: user.login,
                                           avatarUrl: user.avatarUrl,
                                           name: user.name,
                                           bio: user.bio,
                                           followers: followers.count,
                                           following: user.following)
                    
                    self.user = updatedUser
                }//if
            })//sink
            .store(in: &cancellables)
    }//fetchFollowers
    
    /**
     Fetch the number of following users for the given username
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchFollowing(username: String) {
        isLoading = true
        
        apiManager.fetchFollowing(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Following API: receive error: \(error)")
                }
            }, receiveValue: { [weak self] following in
                guard let self = self else { return }
                
                if let user = self.user {
                    let updatedUser = User(login: user.login,
                                           avatarUrl: user.avatarUrl,
                                           name: user.name,
                                           bio: user.bio,
                                           followers: user.followers,
                                           following: following.count)
                    
                    self.user = updatedUser
                }//if let
            })
            .store(in: &cancellables)
    }//fetchFollowing
    
}//UserProfileViewModel
