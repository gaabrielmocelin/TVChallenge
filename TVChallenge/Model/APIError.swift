//
//  APIError.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import Foundation

struct APIError: Error, Decodable {
    let name: String
    let message: String?
    let code: Int?
    let status: Int?

    init(name: String, message: String? = nil, code: Int? = nil, status: Int?) {
        self.name = name
        self.message = message
        self.code = code
        self.status = status
    }
}
