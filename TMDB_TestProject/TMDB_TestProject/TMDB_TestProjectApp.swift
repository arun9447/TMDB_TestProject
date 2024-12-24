//
//  TMDB_TestProjectApp.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

// MARK: - Entry point to the app, handle here to load first view of the application.
@main
struct TMDB_TestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            PeopleListView()
        }
    }
}
