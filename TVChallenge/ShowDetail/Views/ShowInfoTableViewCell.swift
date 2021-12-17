//
//  ShowInfoTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class ShowInfoTableViewCell: UITableViewCell {
    private lazy var stack = UIStackView(arrangedSubviews: [summaryLabel, scheduleLabel, genresLabel])
    private let summaryLabel = UILabel()
    private let genresLabel = UILabel()
    private let scheduleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(summary: String?, genres: String, schedule: String) {
        summaryLabel.text = summary
        genresLabel.text = genres
        scheduleLabel.text = schedule
    }
}

extension ShowInfoTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(stack)
    }

    func setupConstraints() {
        stack.constraintsEqual(to: contentView, top: 24, bottom: -24, leading: 16, trailing: -16)
    }

    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none

        stack.axis = .vertical
        stack.spacing = 8

        summaryLabel.numberOfLines = 0

        scheduleLabel.numberOfLines = 0
        scheduleLabel.textColor = .secondaryLabel

        genresLabel.numberOfLines = 0
        genresLabel.textColor = .secondaryLabel
    }
}
