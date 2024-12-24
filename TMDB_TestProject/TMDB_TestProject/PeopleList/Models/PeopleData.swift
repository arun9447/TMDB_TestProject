//
//  PeopleData.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

struct PeopleData: Codable, Identifiable {
    let id: Int
    let name: String
    let profile_path: String?
    let known_for_department: String?
}
