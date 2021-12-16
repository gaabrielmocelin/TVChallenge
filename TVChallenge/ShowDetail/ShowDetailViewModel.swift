//
//  ShowViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import Foundation

protocol ShowDetailViewModelDelegate: AnyObject {
    func didFetchEpisodes()
    func didFailToFetchEpisodes(error: APIError)
}

final class ShowDetailViewModel: ViewModel {
    let showService: ShowServiceProtocol
    let show: Show

    weak var delegate: ShowDetailViewModelDelegate?

    var summary: String {
        show.summary.removeHTMLTags()
    }

    var genres: String {
        "Genres: \(show.genres.joined(separator: "; "))"
    }

    var schedule: String {
        "Schedule: \(show.schedule.time) - \(show.schedule.days.joined(separator: ", "))"
    }

    var episodes: [Int: [Episode]] = [:]

    var seasons: [Int] {
        episodes.keys.map { $0 }.sorted()
    }

    init(showService: ShowServiceProtocol, show: Show) {
        self.showService = showService
        self.show = show
    }

    func fetchEpisodes() {
        showService.fetchEpisodes(of: show) { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.episodes = Dictionary(grouping: episodes) { $0.season }
                self?.delegate?.didFetchEpisodes()

            case .failure(let error):
                self?.delegate?.didFailToFetchEpisodes(error: error)
            }
        }
    }
}
