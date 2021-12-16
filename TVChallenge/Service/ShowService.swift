//
//  ShowService.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import Foundation
import Alamofire

protocol ShowServiceProtocol {
    func fetchShows(page: Int, completion: @escaping (Result<[Show], APIError>) -> Void)
    func searchShows(for query: String, completion: @escaping (Result<[Show], APIError>) -> Void)
    func fetchEpisodes(of show: Show, completion: @escaping (Result<[Episode], APIError>) -> Void)
}

final class ShowService: ShowServiceProtocol {
    func fetchShows(page: Int, completion: @escaping (Result<[Show], APIError>) -> Void) {
        AF.request(Path.shows, parameters: ["page": page]).responseDecodable { (response: DataResponse<[Show], AFError>) in
            switch response.result {
            case .success(let shows):
                completion(.success(shows))

            case .failure(let error):
                let apiError = try? JSONDecoder().decode(APIError.self, from: response.data ?? Data())
                completion(.failure(apiError ?? APIError(name: error.localizedDescription, status: error.responseCode)))
            }
        }
    }

    func searchShows(for query: String, completion: @escaping (Result<[Show], APIError>) -> Void) {
        AF.request(Path.search, parameters: ["q": query]).responseDecodable { (response: DataResponse<[SearchedShow], AFError>) in
            switch response.result {
            case .success(let searchedShows):
                completion(.success(searchedShows.map(\.show)))

            case .failure(let error):
                let apiError = try? JSONDecoder().decode(APIError.self, from: response.data ?? Data())
                completion(.failure(apiError ?? APIError(name: error.localizedDescription, status: error.responseCode)))
            }
        }
    }

    func fetchEpisodes(of show: Show, completion: @escaping (Result<[Episode], APIError>) -> Void) {
        AF.request(Path.episodes(showId: show.id)).responseDecodable { (response: DataResponse<[Episode], AFError>) in
            switch response.result {
            case .success(let episodes):
                completion(.success(episodes))

            case .failure(let error):
                let apiError = try? JSONDecoder().decode(APIError.self, from: response.data ?? Data())
                completion(.failure(apiError ?? APIError(name: error.localizedDescription, status: error.responseCode)))
            }
        }
    }
}
