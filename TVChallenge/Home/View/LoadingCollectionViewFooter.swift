//
//  LoadingTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit

final class LoadingCollectionViewFooter: UICollectionViewCell {
    private let loadingView = LoadingView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {
        loadingView.startAnimation()
    }

    func stopAnimation() {
        loadingView.stopAnimation()
    }
}

extension LoadingCollectionViewFooter: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(loadingView)
    }

    func setupConstraints() {
        loadingView.constraintsEqual(to: contentView)
    }

    func configureViews() { }
}
