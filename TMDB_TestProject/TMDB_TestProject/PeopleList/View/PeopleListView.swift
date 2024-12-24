//
//  PeopleListView.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI
import Combine

// MARK: - PeopleListView
struct PeopleListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = PeopleListViewModel()
    @AppStorage("selectedThemeColor") private var selectedThemeColorHex: String = "#FFFFFF" // Hex code for selected color
    @State private var showSettings = false // Declare the state to control the settings screen

    // Convert hex string to Color
    private var selectedThemeColor: Color {
        Color(hex: selectedThemeColorHex)
    }

    // Darker shade for header
    private var headerColor: Color {
        selectedThemeColor.darker()
    }

    // Lighter shade for search bar
    private var searchBarColor: Color {
        selectedThemeColor.lighter()
    }

    // A different shade for list background
    private var listCellColor: Color {
        selectedThemeColor.opacity(0.1)
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                headerView
                    .background(selectedThemeColor.darker())
                // Search Bar
                SearchBar(text: $viewModel.searchQuery)
                    .padding(.top)
                    .background(searchBarColor) // Lighter shade for the search bar
                    
                ScrollView {
                    LazyVStack {
                        peopleList
                        progressView
                        bottomLineView
                    }
                    .background(selectedThemeColor.lighter())
                }
                .background(selectedThemeColor.lighter())
                // Apply a subtle background shade
                .onAppear {
                    if viewModel.people.isEmpty { // Fetch initial data if empty
                        viewModel.fetchPeople()
                    }
                }
                .navigationBarHidden(true)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(showSettings: $showSettings) // Pass binding to dismiss settings view
            }
        }
        .background(selectedThemeColor.lighter())
    }

    // MARK: - ChildViews/subViews
    private var headerView: some View {
        CustomHeaderView(
            title: "Popular People",
            customImage: Image(systemName: "gear"),
            themeColor: headerColor, // Darker shade for header
            onImageTapped: {
                showSettings.toggle()
            }
        )
    }
    
    private var peopleList: some View {
        // Loop through the filtered people array and display each person using PeopleListCell
        ForEach(viewModel.people) { actorObj in
            NavigationLink(destination: PeopleDetailsView(personId: actorObj.id)) {
                PeopleListCell(person: actorObj)
                    .background(listCellColor) // Apply the lighter shade for list cell background
            }
        }
    }
    
    private var progressView: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
    }
    
    private var bottomLineView: some View {
        Color.clear
            .frame(height: 1)
            .onAppear {
                if !viewModel.isLoading {
                    viewModel.fetchPeople()
                }
            }
    }
}


#Preview {
    PeopleListView()
}
