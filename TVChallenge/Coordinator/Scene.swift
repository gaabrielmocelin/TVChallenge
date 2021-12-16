//
//  Scene.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

/// Each ViewController has a correspondent Scene which holds its ViewModel
enum Scene {
    case home(HomeViewModel)
    case showDetail(ShowDetailViewModel)
    case episodeDetail(EpisodeDetailViewModel)

    func viewController(coordinator: Coordinator) -> UIViewController {
        switch self {
        case .home(let viewModel):
            return HomeViewController(coordinator: coordinator, viewModel: viewModel).embedInNavigation()

        case .showDetail(let viewModel):
            return ShowDetailViewController(coordinator: coordinator, viewModel: viewModel)

        case .episodeDetail(let viewModel):
            return EpisodeDetailViewController(coordinator: coordinator, viewModel: viewModel)
        }
    }
}
