//
//  ExpandableText.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

// MARK: - ExpandableText View
struct ExpandableText: View {
    let text: String
    @Binding var isExpanded: Bool
    @Binding var showReadMore: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(text)
                .font(.body)
                .lineLimit(isExpanded ? nil : 4)
                .background(
                    Text(text)
                        .font(.body)
                        .lineLimit(4)
                        .background(GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let fullHeight = geometry.size.height
                                    let lineHeight = UIFont.preferredFont(forTextStyle: .body).lineHeight
                                    showReadMore = fullHeight > lineHeight * 4
                                }
                        })
                        .hidden()
                )
                .padding(.bottom, showReadMore ? 8 : 0) // Add spacing between text and button

            if showReadMore {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? "Read Less" : "Read More")
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
