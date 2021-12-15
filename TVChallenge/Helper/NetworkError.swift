//
//  NetworkError.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case unableToParseJSON
}
