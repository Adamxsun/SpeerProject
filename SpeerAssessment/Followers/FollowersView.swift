//
//  FollowersView.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 3:22 pm mst

import Foundation
import SwiftUI

struct FollowersView: View {
    // The username to fetch the following list for
    let username: String
    // Environment variable for managing the presentation mode
    @Environment(\.presentationMode) var presentationMode
    // Instance of the FollowingViewModel
    @StateObject private var viewModel = FollowersViewModel()
    
    var body: some View {
        VStack {
            if let usernames = viewModel.usernames {
                // Display the list of usernames if available
                List(usernames, id: \.self) { username in
                    Text(username)
                }
            }//if
            else if viewModel.isLoading {
                // Display a progress view while loading
                ProgressView()
            }//else
            else {
                // Display a message if the user is not following anyone
                Text("Not following anyone")
                    .foregroundColor(.gray)
            }//else
        }//VStack
        .navigationTitle("Followers")
        .onAppear {
            viewModel.fetchFollowers(username: username)
        }//VStack
    }//body
}//FollowersView
