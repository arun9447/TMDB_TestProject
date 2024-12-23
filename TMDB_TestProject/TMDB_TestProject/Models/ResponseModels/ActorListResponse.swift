//
//  ActorListResponse.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation

struct ActorListResponse: Codable {
    let page: Int
    let results: [Actor]
    let total_pages: Int
}
