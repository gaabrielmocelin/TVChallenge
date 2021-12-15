//
//  ShowTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit
import AlamofireImage

final class ShowTableViewCell: UITableViewCell {
    private let containerView = UIView()
    private let showImageView = UIImageView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(show: Show) {
        titleLabel.text = show.name

        if let url = URL(string: show.image.medium) {
            showImageView.af.setImage(withURL: url, cacheKey: show.image.medium, imageTransition: .crossDissolve(0.3))
        }
    }
}

extension ShowTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(showImageView)
        containerView.addSubview(titleLabel)
    }

    func setupConstraints() {
        containerView.constraintsEqual(to: contentView, top: 12, bottom: -12, leading: 20, trailing: -20)

        showImageView.translatesAutoresizingMaskIntoConstraints = false
        showImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        showImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        showImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        showImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }

    func configureViews() {
        selectionStyle = .none

        containerView.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.tertiaryLabel.cgColor

        titleLabel.numberOfLines = 0

        showImageView.backgroundColor = .secondarySystemBackground
        showImageView.contentMode = .scaleAspectFill
        showImageView.clipsToBounds = true
    }
}
