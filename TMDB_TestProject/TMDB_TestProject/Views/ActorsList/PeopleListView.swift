//
//  PeopleListView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

struct PeopleListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = PeopleListViewModel()

    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                headerView
                // Search Bar
                SearchBar(text: $viewModel.searchQuery)
                    .padding(.top)
                ScrollView {
                    LazyVStack {
                        peopleList
                        progressView
                        bottomLineView
                    }
                }
                .onAppear {
                    if viewModel.people.isEmpty { // Fetch initial data if empty
                        viewModel.fetchPeople()
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
    private var headerView: some View {
        // Custom HeaderView
               CustomHeaderView(
                   title: "Popular People", // Optional title
                   customImage: Image(systemName: "gear"), // Optional custom image
                   onImageTapped: {
                       print("Custom Image tapped")
                   }
               )
    }
    private var peopleList: some View {
        // Loop through the filtered people array and display each person using PeopleListCell
        ForEach(viewModel.people) { actorObj in
            NavigationLink(destination: PeopleDetailsView(personId: actorObj.id)) {
                PeopleListCell(person: actorObj)
            }
        }
    }
    
    private var progressView: some View {
        // Show loading indicator while fetching data
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
    }
    
    private var bottomLineView: some View {
            // Detect when to load more
            Color.clear
                .frame(height: 1)
            // Invisible view to detect when the user has scrolled to the bottom
                .onAppear {
                    if !viewModel.isLoading {
                        viewModel.fetchPeople()
                        // Fetch more people when reaching the end
                    }
                }
    }
}

#Preview {
    PeopleListView()
}
