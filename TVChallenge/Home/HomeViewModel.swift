//
//  HomeViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import Foundation

final class HomeViewModel: ViewModel {
    private let showService: ShowServiceProtocol

    private var lastShowsPageDownloaded = 0

    init(showService: ShowServiceProtocol = ShowService()) {
        self.showService = showService
    }

    func fetchShows() {
        showService.fetchShows(page: lastShowsPageDownloaded) { result in
            switch result {
            case .success(let shows):
                print(shows)

            case .failure(let error):
                print(error.status)
            }
        }
    }
}
