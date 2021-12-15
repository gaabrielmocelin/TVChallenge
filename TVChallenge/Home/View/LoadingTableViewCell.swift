//
//  LoadingTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {
        activityIndicator.startAnimating()
    }
}

extension LoadingTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(activityIndicator)
    }

    func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func configureViews() {
        selectionStyle = .none
        activityIndicator.color = .secondaryLabel
    }
}
