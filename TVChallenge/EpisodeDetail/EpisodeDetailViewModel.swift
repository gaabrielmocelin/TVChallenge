//
//  EpisodeViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import Foundation

final class EpisodeDetailViewModel: ViewModel {
    // MARK: - Services + Dependency Injection
    let episode: Episode

    // MARK: - Episode Info formatted
    var title: String {
        "\(episode.number). \(episode.name)"
    }

    var season: String {
        "Season \(episode.season)"
    }

    var summary: String? {
        episode.summary?.removeHTMLTags()
    }

    // MARK: - Init
    init(episode: Episode) {
        self.episode = episode
    }
}
