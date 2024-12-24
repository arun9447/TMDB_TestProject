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
    @AppStorage("selectedThemeColor") private var selectedThemeColorHex: String = "#FFFFFF" // Hex code for selected color
    
    @Environment(\.presentationMode) private var presentationMode // For dismissing the view


    // Convert hex string to Color
    private var selectedThemeColor: Color {
        Color(hex: selectedThemeColorHex)
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                headerView
                ScrollView {
                    VStack(alignment: .leading) {
                        personalInfoView
                        galleryContentView
                    }
                    .background(selectedThemeColor.opacity(0.7))
                }
            }
            .background(selectedThemeColor.opacity(0.7)) // Apply the selected theme color as background
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
        .navigationBarHidden(true)

    }
    
    // MARK: - ChildViews/subViews
    private var headerView: some View {
        CustomHeaderView(
            title: "",
            customImage:  Image(systemName: "square.and.arrow.up"),
            themeColor: selectedThemeColor.darker(), // Darker shade for header,
            onBackTapped: {
                presentationMode.wrappedValue.dismiss()

            }, onImageTapped: {
                isSharing = true
            }
        )
    }
    
    private var personalInfoView: some View {
        Group {
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
        }
    }
    
    private var galleryContentView: some View {
        Group {
            if !viewModel.images.isEmpty {
                galleryTitleView
                galleryView
            }
        }
    }
    
    private var galleryTitleView: some View {
        HStack {
            Text("Gallery")
                .font(.headline)
                .padding()
            Spacer()
//            Button(action: {
//                isSharing = true
//            }) {
//                Image(systemName: "square.and.arrow.up")
//                    .font(.title2)
//            }
        }
        .padding(.trailing, 25)
    }

    private var galleryView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
            ForEach(viewModel.images, id: \.file_path) { image in
                CustomImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w200\(image.file_path)")!)
                    .frame(height: 150)
                    .clipped()
                    .onTapGesture {
                        selectedImage = IdentifiableImage(url: "https://image.tmdb.org/t/p/original\(image.file_path)")
                    }
            }
        }
    }
}
