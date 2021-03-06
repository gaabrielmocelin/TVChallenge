//
//  Path.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 30/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

enum Path {
    static private let baseUrl = "https://api.tvmaze.com"
    
    static var shows = "\(Path.baseUrl)/shows"
    static var search = "\(Path.baseUrl)/search/shows"

    static func episodes(showId: Int) -> String {
        "\(Path.baseUrl)/shows/\(showId)/episodes"
    }
}
