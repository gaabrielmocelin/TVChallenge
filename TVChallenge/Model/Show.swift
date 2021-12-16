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

    struct Image: Decodable {
        let medium: String
    }
}

struct SearchedShow: Decodable {
    let show: Show
}
