//
//  UserProfileSkeletonView.swift
//  SpeerAssessment
//
//  Created by Xiao Sun on 2023-06-13.
//  Start this class at 4:01 pm mst

import Foundation
import SwiftUI

struct UserProfileSkeletonView: View {
    var body: some View {
        VStack {
            // Skeleton screen design and layout
            // This can include placeholder shapes, text, or images
            Color.gray.opacity(0.3)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text("Loading")
                .font(.title)
                .bold()
                .padding(.top, 8)
            
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.3))
                .frame(width: 200, height: 12)
                .padding(.top, 8)
            
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.3))
                .frame(width: 200, height: 80)
                .padding(.top, 8)
            
            HStack {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 40)
                
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 40)
            }
            .padding(.top, 16)
            
            Spacer()
        }//VStack
    }//body
}//UserProfileSkeletonView
