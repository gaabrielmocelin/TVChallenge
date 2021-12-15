//
//  Coordinator.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

/// Possible transitions the app may perform
enum TransitionType {
    case root
    case push
    case modal(UIModalPresentationStyle = .pageSheet)
    case detail
}

/// Handles all the navigation flow of the app
final class Coordinator {
    private(set) weak var window: UIWindow?

    public init(window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func start(scene: Scene, type: TransitionType) {
        let viewController = scene.viewController(coordinator: self)
        window?.rootViewController = viewController
    }

    func transition(from: UIViewController, to scene: Scene, type: TransitionType) {
        let viewController = scene.viewController(coordinator: self)

        switch type {
        case .root:
            window?.rootViewController = viewController

        case .push:
            guard let navigationController = from.navigationController else {
                fatalError("can not present vc without a current navigation")
            }

            navigationController.pushViewController(viewController, animated: true)

        case .modal(let modalStyle):

            viewController.modalPresentationStyle = modalStyle
            from.present(viewController, animated: true)

        case .detail:
            guard let splitController = from.splitViewController else {
                fatalError("the source vc isn't a split view controller to show a detail")
            }

            splitController.showDetailViewController(viewController, sender: nil)
        }
    }
}
