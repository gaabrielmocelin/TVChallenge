//
//  SearchViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import Foundation

final class SearchViewModel: ViewModel {
    private let showService: ShowServiceProtocol

    init(showService: ShowServiceProtocol = ShowService()) {
        self.showService = showService
    }

    func search(for query: String) {
        showService.searchShows(for: query) { result in
            switch result {
            case .success(let shows):
                print(shows)

            case .failure(let error):
                print(error)
            }
        }
    }
}
