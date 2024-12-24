//
//  CustomHeaderView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

struct CustomHeaderView: View {
    var title: String?
    var customImage: Image?
    var onImageTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            // Title (if provided)
            if let title = title {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            } else {
                Spacer() // Space if no title
            }
            
            Spacer()
            
            // Custom Image with action (if provided)
            if let customImage = customImage {
                Button(action: {
                    onImageTapped?()
                }) {
                    customImage
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .background(Color.white)
        .shadow(radius: 5)
    }
}

#Preview {
    CustomHeaderView()
}
