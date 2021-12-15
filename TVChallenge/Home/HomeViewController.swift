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

    var viewState: ViewState = .loading {
        didSet {
            if viewState != oldValue {
                updateUI(for: viewState)
            }
        }
    }

    // MARK: - Views
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

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

        tableView.register(type: ShowTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self

        updateUI(for: viewState)
    }
}

// MARK: - View State
extension HomeViewController {
    enum ViewState {
        case loading
        case loaded
    }

    private func updateUI(for state: ViewState) {
        DispatchQueue.main.async { [unowned self] in
            switch state {
            case .loading:
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.tableView.isHidden = true

            case .loaded:
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
            }
        }
    }
}

// MARK: - Table View Delegate & Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.shows.count
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
}

// MARK: - View Model Delegate
extension HomeViewController: HomeViewModelDelegate {
    func didFetchNewShows(indexes: [IndexPath]) {
        viewState = .loaded
        tableView.insertRows(at: indexes, with: .automatic)
    }

    func didFailToFetchShows(error: APIError) {
        let okAction = AlertAction(title: "Ok", style: .default, action: { _ in })

        let retryAction = AlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.fetchShows()
        }

        presentAlert(title: error.name, message: error.message, actions: [okAction, retryAction])
    }
}
