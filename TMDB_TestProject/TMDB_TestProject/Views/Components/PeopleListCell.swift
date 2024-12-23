//
//  PeopleListCell.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

struct PeopleListCell: View {
    let person: PeopleData
    
    var body: some View {
        HStack {
            // Image with overlay text
            ZStack(alignment: .bottomTrailing) { // Align overlay text at the bottom right
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(person.profile_path ?? "")")) { image in
                    image
                        .resizable()
                        .scaledToFill() // Make sure the image fills the frame
                        .frame(width: 120, height: 120) // Medium-sized rectangle
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    Color.gray.opacity(0.3) // Background color while image is loading
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                // Overlay text for category
                Text(person.known_for_department ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.7)) // Background for better text visibility
                    .cornerRadius(5)
                    .padding([.bottom, .trailing], 5)
            }
            .padding(.leading)

            // Name of the person
            Text(person.name)
                .font(.headline)
                .lineLimit(1)
                .padding(.leading, 10)
            
            Spacer() // To push text to the left
        }
        .padding(.vertical, 5) // Vertical padding to avoid overlap
        .background(Color.white) // White background to distinguish each cell
        .cornerRadius(10) // Rounded corners for the cell
        .shadow(radius: 5) // Optional: Add shadow for visual depth
        .padding(.horizontal) // Horizontal padding to prevent overlap
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
