//
//  Show.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import Foundation

struct Show: Decodable {
    let id: Int
    let name: String
    let image: Image?
    let genres: [String]
    let summary: String
    let schedule: Schedule

    struct Image: Decodable {
        let medium: String
    }

    struct Schedule: Decodable {
        let time: String
        let days: [String]
    }
}

struct SearchedShow: Decodable {
    let show: Show
}
