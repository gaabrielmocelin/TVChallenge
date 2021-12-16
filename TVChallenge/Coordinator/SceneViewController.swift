//
//  SceneViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

/// ViewModels must conform to this protocol
protocol ViewModel { }

/// View controllers must conform to this protocol
protocol SceneViewController {
    associatedtype T: ViewModel

    var coordinator: Coordinator { get }
    var viewModel: T { get }

    init(coordinator: Coordinator, viewModel: T)
}

extension SceneViewController where Self: UIViewController {
    func transition(to scene: Scene, type: TransitionType) {
        coordinator.transition(from: self, to: scene, type: type)
    }

    func embedInNavigation() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }
}
