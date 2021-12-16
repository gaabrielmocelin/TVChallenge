//
//  SearchViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit

final class SearchViewController: UIViewController, SceneViewController {
    let viewModel: SearchViewModel
    let coordinator: Coordinator

    init(coordinator: Coordinator, viewModel: SearchViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension SearchViewController: ViewConfigurator {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func configureViews() {

    }
}
