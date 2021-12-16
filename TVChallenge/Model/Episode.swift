//
//  Episode.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import Foundation

struct Episode: Decodable {
    let season: Int
    let number: Int
    let name: String
    let summary: String?
    let image: Image?
}
