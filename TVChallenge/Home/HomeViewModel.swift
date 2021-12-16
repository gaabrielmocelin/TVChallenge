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
    // MARK: - Services
    private let showService: ShowServiceProtocol

    // MARK: - View Delegate
    weak var delegate: HomeViewModelDelegate? {
        didSet {
            delegate?.didUpdateState(to: state)
        }
    }

    // MARK: - Services
    private(set) var state: HomeState = .loading {
        didSet {
            delegate?.didUpdateState(to: state)
        }
    }

    // MARK: - Properties
    private var downloadedShows: [Show] = []
    private var currentPageToDownload = 0
    private(set) var isLoadingMoreShows = false

    private var searchedShows: [Show] = []

    var shows: [Show] {
        state == .default ? downloadedShows : searchedShows
    }

    // MARK: - Init
    init(showService: ShowServiceProtocol = ShowService()) {
        self.showService = showService
    }

    // MARK: - Fetch Shows + Pagination
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

    ///due to pagination, we only insert the new rows instead of reload all table
    private func getNewIndexesToInsert(_ newShows: [Show]) -> [IndexPath] {
       let startIndex = downloadedShows.count - newShows.count
       let endIndex = startIndex + newShows.count
       return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    // MARK: - Search
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

    // MARK: - Children ViewModel
    func getShowDetailViewModel(for index: IndexPath) -> ShowDetailViewModel {
        ShowDetailViewModel(showService: showService, show: shows[index.row])
    }
}
