//
//  ShareSheet.swift
//  TMDB_TestProject
//
//  Created by Arunkumar K M on 24/12/24.
//

import SwiftUI

// MARK: - Shareview to share between the Apps
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No updates needed
    }
}
