//
//  apiManager.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 1:52 pm mst

import Foundation
import Combine

class ApiManager {
    //initial url
    private let baseURL = "https://api.github.com"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /**
     Fetch user profile info
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchUserProfile(username: String) -> AnyPublisher<User, Error> {
        // Create the URL for fetching following
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }//else
        
        return session.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .flatMap { data, _ in
                Just(data)
                    .decode(type: User.self, decoder: JSONDecoder())
                    .mapError { $0 as Error }
            }
            .print("User Profile API") // Print the result
            .eraseToAnyPublisher()
    }//fetchUserProfile
    
    /**
     Fetch user's followers info'
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchFollowers(username: String) -> AnyPublisher<[Follower], Error> {
        // Create the URL for fetching following
        guard let url = URL(string: "\(baseURL)/users/\(username)/followers") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }//else
        
        return session.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .flatMap { data, _ in
                Just(data)
                    .decode(type: [Follower].self, decoder: JSONDecoder())
                    .mapError { $0 as Error }
            }
            .eraseToAnyPublisher()
    }//fetchFollowers
    /**
     Fetch user's following user's info
     
     - Parameters:
        - username: user name on Github.
     */
    func fetchFollowing(username: String) -> AnyPublisher<[Follower], Error> {
        // Create the URL for fetching following
        guard let url = URL(string: "\(baseURL)/users/\(username)/following") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }//else
        
        return session.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .flatMap { data, _ in
                Just(data)
                    .decode(type: [Follower].self, decoder: JSONDecoder())
                    .mapError { $0 as Error }
            }
            .eraseToAnyPublisher()
    }//fetchFollowing
}//apiManager
