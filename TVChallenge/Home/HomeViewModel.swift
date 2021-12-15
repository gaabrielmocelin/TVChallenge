//
//  HomeViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchNewShows(indexes: [IndexPath])
    func didFailToFetchShows(error: APIError)
}

final class HomeViewModel: ViewModel {
    private let showService: ShowServiceProtocol

    weak var delegate: HomeViewModelDelegate?

    private(set) var shows: [Show] = []
    private var currentPageToDownload = 0

    init(showService: ShowServiceProtocol = ShowService()) {
        self.showService = showService
    }

    func fetchShows() {
        showService.fetchShows(page: currentPageToDownload) { [weak self] result in
            switch result {
            case .success(let shows):
                self?.shows += shows
                let indexes = self?.getNewIndexesToInsert(shows) ?? []
                self?.delegate?.didFetchNewShows(indexes: indexes)
                self?.currentPageToDownload += 1

            case .failure(let error):
                if error.status == 404 {
                    print("Pagination has finished")
                } else {
                    self?.delegate?.didFailToFetchShows(error: error)
                }
            }
        }
    }

    ///due to pagination, we only insert the new rows instead of reload all table
    private func getNewIndexesToInsert(_ newShows: [Show]) -> [IndexPath] {
       let startIndex = shows.count - newShows.count
       let endIndex = startIndex + newShows.count
       return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
