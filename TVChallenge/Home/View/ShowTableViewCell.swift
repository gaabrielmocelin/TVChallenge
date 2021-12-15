//
//  ShowTableViewCell.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit
import AlamofireImage

final class ShowTableViewCell: UICollectionViewCell {
    private let showImageView = UIImageView()
    private let gradientView = GradientView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        showImageView.image = nil
    }

    func set(show: Show) {
        titleLabel.text = show.name

        if let image = show.image, let url = URL(string: image.medium) {
            showImageView.af.setImage(withURL: url, cacheKey: image.medium, imageTransition: .crossDissolve(0.3))
        }
    }
}

extension ShowTableViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(showImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        showImageView.constraintsEqual(to: contentView)

        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -40).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    func configureViews() {
        contentView.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.tertiaryLabel.cgColor

        titleLabel.numberOfLines = 3
        titleLabel.textColor = .systemBackground

        gradientView.horizontalMode = false
        gradientView.startColor = .clear
        gradientView.endColor = .black

        showImageView.backgroundColor = .secondarySystemBackground
        showImageView.contentMode = .scaleAspectFill
        showImageView.clipsToBounds = true
    }
}
