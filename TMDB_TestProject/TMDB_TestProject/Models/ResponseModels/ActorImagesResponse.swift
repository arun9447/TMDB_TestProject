//
//  ActorImagesResponse.swift
//  TMDBTest
//
//  Created by Arunkumar K M on 23/12/24.
//

import Foundation

struct ActorImagesResponse: Decodable {
    let id: Int
    let profiles: [ProfileImage]
}
