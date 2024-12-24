//
//  PeopleDetailsView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI
import UIKit

struct PeopleDetailsView: View {
    // MARK: - Properties
    let personId: Int
    @StateObject private var viewModel = PeopleDetailViewModel()
    @State private var isExpanded = false
    @State private var selectedImage: IdentifiableImage? = nil
    @State private var isSharing = false // Track the share sheet visibility
    @State private var showReadMore = false // Control visibility of Read More button

    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let person = viewModel.person {
                        Text(person.name)
                            .font(.largeTitle)
                            .padding()

                        VStack(alignment: .leading, spacing: 5) {
                            if let biography = person.biography, !biography.isEmpty {
                                ExpandableText(
                                    text: biography,
                                    isExpanded: $isExpanded,
                                    showReadMore: $showReadMore
                                )
                                .padding(.horizontal)
                            } else {
                                Text("Biography not available at the moment")
                                    .font(.body)
                                    .padding(.horizontal)
                            }
                        }
                    }

                    if !viewModel.images.isEmpty {
                        HStack {
                            Text("Gallery")
                                .font(.headline)
                                .padding()
                            Spacer()
                            Button(action: {
                                isSharing = true
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                            }
                        }
                        .padding(.trailing, 25)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                            ForEach(viewModel.images, id: \.file_path) { image in
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(image.file_path)"))
                                    .frame(height: 150)
                                    .clipped()
                                    .onTapGesture {
                                        selectedImage = IdentifiableImage(url: "https://image.tmdb.org/t/p/original\(image.file_path)")
                                    }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchPersonDetails(personId: personId)
                viewModel.fetchGallery(personId: personId)
            }
            .fullScreenCover(item: $selectedImage) { selectedImage in
                FullScreenImageView(imagePath: selectedImage.url)
            }
            .sheet(isPresented: $isSharing) {
                if let shareItems = viewModel.shareableImages() {
                    ShareSheet(activityItems: shareItems)
                }
            }
        }
    }
}


#Preview {
    PeopleDetailsView(personId: 123)
}
