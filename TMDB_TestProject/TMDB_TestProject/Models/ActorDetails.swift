//
//  ActorDetails.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import SwiftUI

struct ActorDetails: Codable {
    let id: Int
    let name: String
    let biography: String?
    let birthday: String?
    let profile_path: String?
}
