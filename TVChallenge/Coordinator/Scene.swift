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

    func viewController(coordinator: Coordinator) -> UIViewController {
        switch self {
        case .home(let viewModel):
            return HomeViewController(coordinator: coordinator, viewModel: viewModel)
        }
    }
}
