//
//  EpisodeViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class EpisodeDetailViewController: UIViewController, SceneViewController {
    let coordinator: Coordinator
    let viewModel: EpisodeDetailViewModel

    private lazy var stack = UIStackView(arrangedSubviews: [episodeImageView])
    private let episodeImageView = UIImageView()


    init(coordinator: Coordinator, viewModel: EpisodeDetailViewModel) {
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

extension EpisodeDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(stack)
    }

    func setupConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true

        episodeImageView.heightAnchor.constraint(equalToConstant: viewModel.episode.image == nil ? 40 : 220).isActive = true
    }

    func configureViews() {
        view.backgroundColor = .secondarySystemBackground

        stack.axis = .vertical
        stack.spacing = 8

        if let image = viewModel.episode.image?.original, let url = URL(string: image) {
            episodeImageView.af.setImage(withURL: url, cacheKey: image, imageTransition: .crossDissolve(0.3))
        }
    }
}
