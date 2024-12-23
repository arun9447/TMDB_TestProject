//
//  ProfileImage.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation

struct ProfileImage: Decodable, Identifiable {
    var id = UUID() // Unique identifier for SwiftUI use
    let aspect_ratio: Double
    let height: Int
    let iso_639_1: String?
    let file_path: String
    let vote_average: Double
    let vote_count: Int
    let width: Int
}
