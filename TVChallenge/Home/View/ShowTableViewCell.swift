//
//  ShowTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit

final class ShowTableViewCell: UITableViewCell {
    private lazy var stack = UIStackView(arrangedSubviews: [showImageView, titleLabel])
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
    }
}

extension ShowTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(stack)
    }

    func setupConstraints() {
        stack.constraintsEqual(to: self, top: 12, bottom: -12, leading: 20, trailing: -20)

        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    func configureViews() {
        stack.axis = .vertical
        stack.spacing = 8
        stack.backgroundColor = .secondarySystemBackground
        stack.cornerRadius = 8

        titleLabel.font = .preferredFont(forTextStyle: .title3)
    }
}
