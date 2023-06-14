//
//  UserProfileView.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 2:19 pm mst

import Foundation
import SwiftUI

struct UserProfileView: View {
    let user: User // The user profile being displayed
    @Environment(\.presentationMode) var presentationMode // Environment variable for managing presentation mode
    @State private var showFollowers = false // Flag for showing followers view
    @State private var showFollowing = false // Flag for showing following view
    @State private var isLoading = true // Flag for indicating if data is loading
    
    var displayName: String {
        user.name ?? "Name: nil"
    }
    
    var displayBio: String {
        user.bio ?? "Bio: nil"
    }
    
    var body: some View {
        VStack {
            if isLoading {
                UserProfileSkeletonView()// Skeleton view while data is loading
            }
            else {
                if let user = user {
                    // Display user profile details
                    AsyncImage(url: URL(string: user.avatarUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    Text(user.login)
                        .font(.title)
                        .bold()
                        .padding(.top, 8)
                    
                    Text(displayName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(displayBio)
                        .font(.body)
                        .padding(.top, 8)
                        .multilineTextAlignment(.center)
                }//if
                else {
                    // Display a message when user profile is not available
                    Text("User profile not found")
                        .font(.title)
                        .foregroundColor(.red)
                }//else
            }//if
            
            HStack {
                Button(action: {
                    showFollowers = true
                }) {
                    Text("Followers: \(user.followers)")
                }
                .padding()
                .sheet(isPresented: $showFollowers) {
                    FollowersView(username: user.login)
                }
                
                Button(action: {
                    showFollowing = true
                }) {
                    Text("Following: \(user.following)")
                }
                .padding()
                .sheet(isPresented: $showFollowing) {
                    FollowingView(username: user.login)
                }
            }//HStack
            .padding(.top, 16)
            
            Spacer()
        }//else
        .onAppear {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isLoading = false // Set isLoading to false to indicate data loading is complete
            }//DispatchQueue
        }//onAppear
    }//VStack
}//UserProfileView
