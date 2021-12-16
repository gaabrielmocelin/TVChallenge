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

    private let episodeImageView = UIImageView()
    private lazy var textStack = UIStackView(arrangedSubviews: [titleLabel, seasonLabel, summaryLabel])
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let seasonLabel = UILabel()
    private let dismissButton = UIButton()

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

    @objc private func didTapDismissButton() {
        dismiss(animated: true)
    }
}

extension EpisodeDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(episodeImageView)
        view.addSubview(textStack)
        view.addSubview(dismissButton)
    }

    func setupConstraints() {
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        episodeImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        episodeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        episodeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        episodeImageView.heightAnchor.constraint(equalToConstant: viewModel.episode.image == nil ? 40 : 220).isActive = true

        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.topAnchor.constraint(equalTo: episodeImageView.bottomAnchor, constant: 12).isActive = true
        textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textStack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -8).isActive = true

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }

    func configureViews() {
        view.backgroundColor = .secondarySystemBackground

        if let image = viewModel.episode.image?.original, let url = URL(string: image) {
            episodeImageView.af.setImage(withURL: url, cacheKey: image, imageTransition: .crossDissolve(0.3))
        }

        textStack.axis = .vertical
        textStack.spacing = 8

        titleLabel.text = "\(viewModel.episode.number). \(viewModel.episode.name)"
        titleLabel.numberOfLines = 3
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        seasonLabel.text = "Season \(viewModel.episode.season)"
        seasonLabel.textColor = .tertiaryLabel

        summaryLabel.text = viewModel.episode.summary.removeHTMLTags()
        summaryLabel.numberOfLines = 0

        dismissButton.addBlurEffect(style: .systemChromeMaterialDark, cornerRadius: 16)
        dismissButton.setTitle("X", for: .normal)
        dismissButton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        dismissButton.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
    }
}
