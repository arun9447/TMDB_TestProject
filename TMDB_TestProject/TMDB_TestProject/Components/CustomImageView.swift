//
//  CustomImageView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import Foundation
import SwiftUI

// MARK: - CustomImageLoader to display the downloaded image.
struct CustomImageLoader: View {
    @StateObject private var imageLoader = ImageDownLoader()  // Use the custom image loader
    @State private var image: UIImage? = nil
    
    let url: URL
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image) // Display the downloaded image
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray // Placeholder while the image is loading
                    .frame(width: 150, height: 150)
            }
        }
        .onAppear {
            imageLoader.loadImage(from: url) // Load the image when the view appears
        }
    }
}

