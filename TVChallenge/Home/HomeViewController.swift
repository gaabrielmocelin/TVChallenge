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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let tableViewBottomLoadingView = LoadingView()

    // MARK: - Life Cycle
    init(coordinator: Coordinator, viewModel: HomeViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        viewModel.fetchShows()
    }

    private func checkIfShouldShowActivityIndicator() {
        // Shows Activity Indicator on center of screen if is initial loading
        activityIndicator.isHidden = !viewModel.shows.isEmpty
        viewModel.shows.isEmpty ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

// MARK: - View Code configuration
extension HomeViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }

    func setupConstraints() {
        tableView.constraintsEqualToSafeArea(of: view)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "TV Shows"

        tableView.separatorStyle = .none
        tableView.tableFooterView = tableViewBottomLoadingView

        tableView.register(type: ShowTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Table View Delegate & Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkIfShouldShowActivityIndicator()

        return section == 0 ? viewModel.shows.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, of: ShowTableViewCell.self)
        cell.set(show: viewModel.shows[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.shows.count - 5 {
            viewModel.fetchShows()
            tableViewBottomLoadingView.startAnimation()
        }
    }
}

// MARK: - View Model Delegate
extension HomeViewController: HomeViewModelDelegate {
    func didFetchNewShows(indexes: [IndexPath]) {
        if !indexes.isEmpty {
            tableView.insertRows(at: indexes, with: .automatic)
        }

        tableViewBottomLoadingView.stopAnimation()
    }

    func didFailToFetchShows(error: APIError) {
        let okAction = AlertAction(title: "Ok", style: .default, action: { _ in })

        let retryAction = AlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.fetchShows()
        }

        presentAlert(title: error.name, message: error.message, actions: [okAction, retryAction])
    }
}
