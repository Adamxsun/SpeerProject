//
//  ContentView.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 1:43 pm mst

import SwiftUI

struct ContentView: View {
    
    @State private var searchText: String = ""
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                //Set up SearchBar for user searching
                SearchBar(text: $searchText, onSearch: fetchUserProfile)
                
                //Display user profile, loading indicator, or not found
                if let user = viewModel.user {
                    UserProfileView(user: user)
                }//if
                else if viewModel.isLoading {
                    ProgressView()
                }//else
                else if viewModel.isUserNotFound {
                    Text("User not found")
                        .foregroundColor(.red)
                }//else
                
                Spacer()
            }//VStack
            .padding()
            .navigationTitle("GitHub Profile")
        }//NavigationView
    }//body
    
    // Fetch user profile based on the search text
    private func fetchUserProfile() {
        viewModel.fetchUserProfile(username: searchText)
    }//fetchUserProfile
}//ContentView

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            // Text field for entering search text
            TextField("Search", text: $text, onCommit: onSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Button to trigger search
            Button(action: onSearch) {
                Text("Search")
            }//Button
        }//HStack
    }//body
}//SearchBar
