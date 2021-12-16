//
//  EpisodeTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {
    private lazy var stack = UIStackView(arrangedSubviews: [titleLabel])
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(episode: Episode?) {
        guard let episode = episode else {
            return
        }
        
        titleLabel.text = episode.name
    }
}

extension EpisodeTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(stack)
    }

    func setupConstraints() {
        stack.constraintsEqual(to: contentView, top: 12, bottom: -12, leading: 16, trailing: -16)
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
