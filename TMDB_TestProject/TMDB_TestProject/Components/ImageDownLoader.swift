//
//  ImageLoader.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import Foundation
import SwiftUI

// MARK: - ImageLoader to handle downloading and caching images
class ImageDownLoader: ObservableObject {
    @Published var image: UIImage? = nil
    
    func loadImage(from url: URL) {
        // Use URLSession to fetch the image asynchronously
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data) // Set the downloaded image
                }
            }
        }.resume()
    }
}
