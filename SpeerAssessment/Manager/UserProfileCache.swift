//
//  UserProfileCache.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 5:14 pm mst

import Foundation

class UserProfileCache {
    private let cacheKey = "UserProfileCache"
    
    /**
     Save user profile to cache
     
     - Parameters:
        - user: User Model
     */
    func saveUserProfile(_ user: User) {
        let encoder = JSONEncoder()
        // Encode user profile as JSON data
        if let encodedData = try? encoder.encode(user) {
            // Store the encoded data in UserDefaults
            UserDefaults.standard.set(encodedData, forKey: cacheKey)
            UserDefaults.standard.set(Date(), forKey: "\(cacheKey)_Timestamp")
        }//if let
    }//saveUserProfile
    
    /**
     Retrieve user profile from cache
     
     - Parameters:
        - user: User Model
     */
    func getUserProfile() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: cacheKey) else {
            return nil
        }//else
        
        let decoder = JSONDecoder()
        
        // Decode user profile from JSON data
        if let user = try? decoder.decode(User.self, from: userData) {
            return user
        }//if let
        
        return nil
    }//getUserProfile
    
    /**
     Check if cache is still valid
     */
    func isCacheValid() -> Bool {
        guard let timestamp = UserDefaults.standard.object(forKey: "\(cacheKey)_Timestamp") as? Date else {
            return false
        }
        
        let currentTime = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: timestamp, to: currentTime)
        
        // Cache expiration time is set to 1 hour
        let cacheExpirationMinutes = 60
        return components.minute ?? 0 <= cacheExpirationMinutes
    }
    /**
     Clear the cache
     */
    func clearCache() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
        UserDefaults.standard.removeObject(forKey: "\(cacheKey)_Timestamp")
    }//clearCache
}//UserProfileCache
