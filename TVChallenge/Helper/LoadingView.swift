//
//  LoadingView.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

final class LoadingView: UICollectionViewCell {
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func stopAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

extension LoadingView: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(activityIndicator)
    }

    func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func configureViews() {
        activityIndicator.color = .secondaryLabel
    }
}
