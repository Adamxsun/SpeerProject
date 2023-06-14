//
//  User.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 2:01 pm mst

import Foundation

//Model for user profile
struct User: Codable, Identifiable, Hashable {
    let id = UUID() // Unique identifier for the user
        
    let login: String // User's login (username)
    let avatarUrl: String // URL of the user's avatar image
    let name: String? // User's name (optional)
    let bio: String? // User's biography (optional)
    let followers: Int // Number of followers
    let following: Int // Number of users the user is following
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name
        case bio
        case followers
        case following
    }
}
