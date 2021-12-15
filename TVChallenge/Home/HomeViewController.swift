//
//  HomeViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

final class HomeViewController: UIViewController, SceneViewController {
    var viewModel: HomeViewModel
    var coordinator: Coordinator

    init(coordinator: Coordinator, viewModel: HomeViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
    }
}

extension HomeViewController: ViewConfigurator {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func configureViews() {
        view.backgroundColor = .systemBackground
    }
}
