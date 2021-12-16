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

    private let tableView = UITableView()

    init(coordinator: Coordinator, viewModel: ShowDetailViewModel) {
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
        viewModel.fetchEpisodes()
    }
}

extension ShowDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        tableView.constraintsEqualToSafeArea(of: view)
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        title = viewModel.show.name

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets (top: 20, left: 0, bottom: 20, right: 0)
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.register(type: ShowImageTableView.self)
        tableView.register(type: ShowInfoTableViewCell.self)
        tableView.register(type: EpisodeTableViewCell.self)
        tableView.dataSource = self
    }
}

extension ShowDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2 + viewModel.seasons.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.show.image == nil ? 0 : 1 // image section
        case 1:
            return 1 // Show info section
        default:
            return viewModel.episodes[section - 1]?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCell(for: indexPath, of: ShowImageTableView.self)
            cell.set(imageUrl: viewModel.show.image?.medium)
            return cell

        case (1,0):
            let cell = tableView.dequeueReusableCell(for: indexPath, of: ShowInfoTableViewCell.self)
            cell.set(summary: viewModel.summary, genres: viewModel.genres, schedule: viewModel.schedule)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, of: EpisodeTableViewCell.self)
            cell.set(episode: viewModel.episodes[indexPath.section - 1]?[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section > 1 else {
            return nil
        }

        return "Season \(viewModel.seasons[section - 2])"
    }
}

extension ShowDetailViewController: ShowDetailViewModelDelegate {
    func didFetchEpisodes() {
        tableView.reloadData()
    }

    func didFailToFetchEpisodes(error: APIError) {
        print(error.name)
    }
}
