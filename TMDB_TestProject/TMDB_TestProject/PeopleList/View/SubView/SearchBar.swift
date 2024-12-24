//
//  SearchBar.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

// MARK: - CustomSearchBar Component
struct SearchBar: View {
    @Binding var text: String
    @AppStorage("selectedThemeColor") private var selectedThemeColorHex: String = "#FFFFFF" // Hex code for selected color
    // Convert hex string to Color
    private var selectedThemeColor: Color {
        Color(hex: selectedThemeColorHex)
    }

    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Spacer()
                        if !text.isEmpty {
                            Button(action: {
                                text = "" // Clear search
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                        .background(selectedThemeColor.lighter())
                )
        }
        .padding(.horizontal)
        .background(selectedThemeColor.lighter())

    }
}

#Preview {
    SearchBar(text: .constant("Tom Cruise"))
}
