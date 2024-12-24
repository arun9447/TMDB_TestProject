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
    @Environment(\.dismiss) private var dismiss

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
                dismiss() // Dismiss the FullScreenCover
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
        AsyncImage(url: URL(string: imagePath)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Text("Failed to load image")
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .padding()
    }
}
