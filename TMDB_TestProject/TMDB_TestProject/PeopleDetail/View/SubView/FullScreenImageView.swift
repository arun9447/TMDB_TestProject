//
//  ZoomableImageView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

// MARK: - FullScreenImageView
struct FullScreenImageView: View {
    let imagePath: String
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
            headerView
            imageView
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private var headerView: some View {
        HStack {
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss the FullScreenCover
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(8)
            }
        }
        .padding(.trailing, 25)
    }
    
    private var imageView: some View {
        CustomImageLoader(url: URL(string: imagePath)!)
            .padding()
    }
}
