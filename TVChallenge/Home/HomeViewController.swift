//
//  HomeViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

final class HomeViewController: UIViewController, SceneViewController {
    // MARK: - Properties
    let viewModel: HomeViewModel
    let coordinator: Coordinator

    // MARK: - Views
    private let tableView = UITableView()

    // MARK: - Life Cycle
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

// MARK: - View Code configuration
extension HomeViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        tableView.constraintsEqualToSafeArea(of: view)
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        title = "TV Shows"
    }
}
