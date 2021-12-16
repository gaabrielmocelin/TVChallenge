//
//  ShowDetailViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class ShowDetailViewController: UIViewController, SceneViewController {
    let coordinator: Coordinator
    let viewModel: ShowDetailViewModel

    init(coordinator: Coordinator, viewModel: ShowDetailViewModel) {
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
        viewModel.fetchEpisodes()
    }
}

extension ShowDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        title = viewModel.show.name
    }
}
