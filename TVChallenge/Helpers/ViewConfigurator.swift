//
//  ViewConfigurator.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import Foundation

///Helper to organize view coding
protocol ViewConfigurator {
    func setupViewConfiguration()
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfigurator {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
