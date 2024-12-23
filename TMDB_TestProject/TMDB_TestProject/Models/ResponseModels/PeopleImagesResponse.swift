//
//  PeopleImagesResponse.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation

struct PeopleImagesResponse: Decodable {
    let id: Int
    let profiles: [ProfileImage]
}
