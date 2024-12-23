//
//  PeopleListResponse.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation

struct PeopleListResponse: Codable {
    let page: Int
    let results: [PeopleData]
    let total_pages: Int
}
