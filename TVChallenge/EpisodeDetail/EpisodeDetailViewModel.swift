//
//  EpisodeViewModel.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import Foundation

final class EpisodeDetailViewModel: ViewModel {
    let episode: Episode

    init(episode: Episode) {
        self.episode = episode
    }
}
