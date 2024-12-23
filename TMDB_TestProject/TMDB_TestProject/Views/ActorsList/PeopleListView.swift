//
//  PeopleListView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

struct PeopleListView: View {
    @StateObject private var viewModel = PeopleListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $viewModel.searchQuery)
                    .padding(.top)

                ScrollView {
                    LazyVStack {
                        // Loop through the filtered people array and display each person using PersonCell
                        ForEach(viewModel.people) { actorObj in
                                PeopleListCell(person: actorObj)
                        }

                        // Show loading indicator while fetching data
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }

                        // Detect when to load more
                        Color.clear
                            .frame(height: 1) // Invisible view to detect when the user has scrolled to the bottom
                            .onAppear {
                                if !viewModel.isLoading {
                                    viewModel.fetchPeople() // Fetch more people when reaching the end
                                }
                            }
                    }
                }
                .onAppear {
                    if viewModel.people.isEmpty { // Fetch initial data if empty
                        viewModel.fetchPeople()
                    }
                }
                .navigationTitle("Favorite Actors")
            }
        }
    }
}




#Preview {
    PeopleListView()
}
