//
//  ShowViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import Foundation

final class ShowDetailViewModel: ViewModel {
    let showService: ShowServiceProtocol
    let show: Show

    var summary: String {
        show.summary.removeHTMLTags()
    }

    var genres: String {
        "Genres: \(show.genres.joined(separator: "; "))"
    }

    var schedule: String {
        "Schedule: \(show.schedule.time) - \(show.schedule.days.joined(separator: ", "))"
    }

    init(showService: ShowServiceProtocol, show: Show) {
        self.showService = showService
        self.show = show
    }

    func fetchEpisodes() {
        showService.fetchEpisodes(of: show) { result in
            switch result {
            case .success(let episodes):
                print(episodes)

            case .failure(let error):
                print(error)
            }
        }
    }
}
