//
//  SearchBar.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
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
                                Image(
                                    systemName: "xmark.circle.fill"
                                )
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                            }
                        }
                    }
                )
        }
        .padding(.horizontal)
    }
}
#Preview {
    SearchBar(text: .constant("Tom Cruise"))
}
