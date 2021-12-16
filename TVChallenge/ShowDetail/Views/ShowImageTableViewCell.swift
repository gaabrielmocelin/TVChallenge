//
//  ShowImageTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class ShowImageTableView: UITableViewCell {
    let showImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(imageUrl: String?) {
        if let image = imageUrl, let url = URL(string: image) {
            showImageView.af.setImage(withURL: url, cacheKey: image, imageTransition: .crossDissolve(0.3))
        }
    }
}

extension ShowImageTableView: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(showImageView)
    }

    func setupConstraints() {
        showImageView.translatesAutoresizingMaskIntoConstraints = false
        showImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        showImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        showImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        showImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        showImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none

        showImageView.cornerRadius = 8
    }
}
