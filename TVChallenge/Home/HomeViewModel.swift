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
    func didUpdateState(to state: HomeState)
}

enum HomeState {
    case loading
    case `default`
    case searched
}

final class HomeViewModel: ViewModel {
    private let showService: ShowServiceProtocol

    weak var delegate: HomeViewModelDelegate? {
        didSet {
            delegate?.didUpdateState(to: state)
        }
    }

    private(set) var state: HomeState = .loading {
        didSet {
            delegate?.didUpdateState(to: state)
        }
    }

    private var downloadedShows: [Show] = []
    private var currentPageToDownload = 0
    private(set) var isLoadingMoreShows = false

    private var searchedShows: [Show] = []

    var shows: [Show] {
        state == .default ? downloadedShows : searchedShows
    }

    init(showService: ShowServiceProtocol = ShowService()) {
        self.showService = showService
    }

    func fetchShows() {
        isLoadingMoreShows = shows.isEmpty ? false : true

        showService.fetchShows(page: currentPageToDownload) { [weak self] result in
            switch result {
            case .success(let shows):
                if self?.state == .loading {
                    self?.state = .default
                }

                self?.downloadedShows += shows
                let indexes = self?.getNewIndexesToInsert(shows) ?? []
                self?.delegate?.didFetchNewShows(indexes: indexes)
                self?.currentPageToDownload += 1

            case .failure(let error):
                self?.delegate?.didFailToFetchShows(error: error)
            }

            self?.isLoadingMoreShows = false
        }
    }

    func search(for query: String) {
        guard !query.isEmpty else {
            state = .default
            return
        }

        state = .loading

        showService.searchShows(for: query) { [weak self] result in
            switch result {
            case .success(let shows):
                self?.searchedShows = shows
                self?.state = .searched

            case .failure(let error):
                self?.delegate?.didFailToFetchShows(error: error)
            }
        }
    }

    ///due to pagination, we only insert the new rows instead of reload all table
    private func getNewIndexesToInsert(_ newShows: [Show]) -> [IndexPath] {
       let startIndex = downloadedShows.count - newShows.count
       let endIndex = startIndex + newShows.count
       return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
