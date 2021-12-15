//
//  HomeViewController.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import UIKit

final class HomeViewController: UIViewController, SceneViewController {
    // MARK: - Properties
    let viewModel: HomeViewModel
    let coordinator: Coordinator

    // MARK: - Views
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateFlowLayout())
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Life Cycle
    init(coordinator: Coordinator, viewModel: HomeViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        viewModel.fetchShows()
    }

    private func checkIfShouldShowActivityIndicator() {
        // Shows Activity Indicator on center of screen if is initial loading
        activityIndicator.isHidden = !viewModel.shows.isEmpty
        viewModel.shows.isEmpty ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    private func generateFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let width: CGFloat = self.view.frame.width / 2 - (padding * 2)
        let height: CGFloat = 300

        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = padding
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 100)

        return layout
    }
}

// MARK: - View Code configuration
extension HomeViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }

    func setupConstraints() {
        collectionView.constraintsEqualToSafeArea(of: view)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "TV Shows"

        collectionView.backgroundColor = .clear
        collectionView.register(type: LoadingView.self, supplementaryKind: UICollectionView.elementKindSectionFooter)
        collectionView.register(type: ShowTableViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Table View Delegate & Data Source
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkIfShouldShowActivityIndicator()

        return viewModel.shows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, of: ShowTableViewCell.self)
        cell.set(show: viewModel.shows[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionFooter:
            return collectionView.dequeueSupplementaryCell(
                for: indexPath,
                of: LoadingView.self,
                kind: UICollectionView.elementKindSectionFooter
            )

        default:
            assert(false, "Invalid element type")
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.shows.count - 5 {
            viewModel.fetchShows()
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {

        if let loadingView = view as? LoadingView {
            viewModel.isLoadingMoreShows ? loadingView.startAnimation() : loadingView.stopAnimation()
        }
    }
}

// MARK: - View Model Delegate
extension HomeViewController: HomeViewModelDelegate {
    func didFetchNewShows(indexes: [IndexPath]) {
        if !indexes.isEmpty {
            collectionView.insertItems(at: indexes)
        }
    }

    func didFailToFetchShows(error: APIError) {
        let okAction = AlertAction(title: "Ok", style: .default, action: { _ in })

        let retryAction = AlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.fetchShows()
        }

        presentAlert(title: error.name, message: error.message, actions: [okAction, retryAction])
    }
}
