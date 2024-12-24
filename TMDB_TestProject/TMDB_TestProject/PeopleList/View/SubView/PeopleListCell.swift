//
//  PeopleListCell.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI
import Combine

// MARK: -  Custom List Cell
struct PeopleListCell: View {
    let person: PeopleData
    @AppStorage("selectedThemeColor") private var selectedThemeColorHex: String = "#FFFFFF" // Hex code for selected color
    // Convert hex string to Color
    private var selectedThemeColor: Color {
        Color(hex: selectedThemeColorHex)
    }

    var body: some View {
        HStack {
            // Image with overlay text
            ZStack(alignment: .bottomTrailing) {
                // Replaced AsyncImage with a manual approach for iOS 14
                if let profilePath = person.profile_path, let url = URL(string: "https://image.tmdb.org/t/p/w200\(profilePath)") {
                    CustomImageLoader(url: url)
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Color.gray.opacity(0.3)
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                // Overlay text for category
                Text(person.known_for_department ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(5)
                    .padding([.bottom, .trailing], 5)
            }
            .padding(.leading)

            // Name of the person
            Text(person.name)
                .font(.headline)
                .lineLimit(1)
                .padding(.leading, 10)
            
            Spacer()
        }
        .padding(.vertical, 5)
        .background(selectedThemeColor.lighter())
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    PeopleListCell(
        person: PeopleData(
            id: 123,
            name: "Tom Cruise",
            profile_path: "https://image.tmdb.org/t/p/w200//7hEhhmAF8Tr7g95fkbuxDpeR27b.jpg",
            known_for_department: "Actor"
        )
    )
}
