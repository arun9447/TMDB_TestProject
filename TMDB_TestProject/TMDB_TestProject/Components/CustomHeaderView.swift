//
//  CustomHeaderView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

// MARK: - CustomHeaderView provides custom navigation bar.
struct CustomHeaderView: View {
    var title: String?
    var customImage: Image?
    var themeColor: Color?
    var onBackTapped: (() -> Void)? // Action for back button
    var onImageTapped: (() -> Void)? // Action for custom image button

    var body: some View {
        HStack {
            // Back Button (if provided)
            if let onBackTapped = onBackTapped {
                Button(action: {
                    onBackTapped()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                        Text("Back")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
            }

            // Title (if provided)
            if let title = title {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            Spacer()

            // Custom Image with action (if provided)
            if let customImage = customImage {
                Button(action: {
                    onImageTapped?()
                }) {
                    customImage
                        .resizable()
                        .frame(width: 25, height: 28)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .background(themeColor?.darker() ?? Color.white)
        .shadow(radius: 5)
    }
}

#Preview {
    CustomHeaderView()
}
