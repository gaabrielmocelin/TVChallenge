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
