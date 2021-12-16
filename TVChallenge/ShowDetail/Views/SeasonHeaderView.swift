//
//  SeasonHeaderView.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class SeasonHeaderView: UIView {
    private let titleLabel = UILabel()

    init(title: String) {
        super.init(frame: .zero)
        setupViewConfiguration()
        titleLabel.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeasonHeaderView: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.constraintsEqual(to: self, leading: 16, trailing: -24)
    }

    func configureViews() {
        backgroundColor = .systemBackground
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
}
