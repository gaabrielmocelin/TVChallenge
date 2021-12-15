//
//  SceneDelegate.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: scene)

        let coordinator = Coordinator(window: window)
        let homeViewModel = HomeViewModel()
        coordinator.start(scene: .home(homeViewModel), type: .root)
    }
}
