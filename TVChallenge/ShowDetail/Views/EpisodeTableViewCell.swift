//
//  EpisodeTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let separatorView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.titleLabel.alpha = self.isHighlighted ? 0.7 : 1
        }
    }

    func set(episode: Episode?) {
        guard let episode = episode else {
            return
        }

        let attributedString = NSMutableAttributedString(
            string: "\(episode.number). ",
            attributes: [.foregroundColor: UIColor.tertiaryLabel]
        )

        attributedString.append(
            NSAttributedString(string: episode.name, attributes: [.foregroundColor: UIColor.systemBlue])
        )

        titleLabel.attributedText = attributedString
    }
}

extension EpisodeTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)

    }

    func setupConstraints() {
        titleLabel.constraintsEqual(to: contentView, top: 16, bottom: -16, leading: 16, trailing: -16)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none

        separatorView.backgroundColor = UIColor.secondarySystemBackground
    }
}
