//
//  PeopleDetailsView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI


struct PeopleDetailsView: View {
    // MARK: - Properties
    let personId: Int
    @StateObject private var viewModel = PeopleDetailViewModel()
    @State private var isExpanded = false // State to toggle between expanded and collapsed text
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let person = viewModel.person {
                    Text(person.name)
                        .font(.largeTitle)
                        .padding()
                    
                    if let biography = person.biography, !biography.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(biography)
                                .font(.body)
                                .lineLimit(isExpanded ? nil : 4) 
                                // Show full text if expanded, otherwise 4 lines
                                .padding(.horizontal)
                            
                            Button(action: {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }) {
                                Text(isExpanded ? "Read Less" : "Read More")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                            }
                        }
                    }
                }
                
                if !viewModel.images.isEmpty {
                    Text("Gallery")
                        .font(.headline)
                        .padding()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        ForEach(viewModel.images, id: \.file_path) { image in
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(image.file_path)"))
                                .frame(height: 150)
                                .clipped()
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPersonDetails(personId: personId)
            viewModel.fetchGallery(personId: personId)
        }
    }
}



#Preview {
    PeopleDetailsView(personId: 123)
}
