//
//  ShowViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import Foundation

protocol ShowDetailViewModelDelegate: AnyObject {
    func didStartToFetchEpisodes()
    func didFetchEpisodes()
    func didFailToFetchEpisodes(error: APIError)
}

final class ShowDetailViewModel: ViewModel {
    // MARK: - Services + Dependency Injection
    let showService: ShowServiceProtocol
    let show: Show

    // MARK: - View Delegate
    weak var delegate: ShowDetailViewModelDelegate?

    // MARK: - Show Info formatted
    var summary: String {
        show.summary.removeHTMLTags()
    }

    var genres: String {
        "Genres: \(show.genres.joined(separator: "; "))"
    }

    var schedule: String {
        "Schedule: \(show.schedule.time) - \(show.schedule.days.joined(separator: ", "))"
    }

    // MARK: - Episodes
    private(set) var episodes: [Int: [Episode]] = [:]

    var seasons: [Int] {
        episodes.keys.map { $0 }.sorted()
    }

    // MARK: - Init
    init(showService: ShowServiceProtocol, show: Show) {
        self.showService = showService
        self.show = show
    }

    // MARK: - Episode functionss
    func fetchEpisodes() {
        delegate?.didStartToFetchEpisodes()

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

    func getEpisodeViewModel(for indexPath: IndexPath) -> EpisodeDetailViewModel? {
        guard let episode = episodes[indexPath.section - 1]?[indexPath.row] else {
            return nil
        }

        return EpisodeDetailViewModel(episode: episode)
    }
}
