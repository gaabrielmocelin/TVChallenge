//
//  Path.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 30/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

struct Path {
    private let baseUrl = "https://gateway.marvel.com/v1/public"
    
    func characteres() -> String {
        return "\(baseUrl)/characters"
    }
    
    func comics(id: Int) -> String {
        return "\(characteres())/\(id)/comics"
    }
}
