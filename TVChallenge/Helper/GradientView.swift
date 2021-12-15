//
//  GradientView.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit

public class GradientView: UIView {
    var startColor: UIColor = .clear {
        didSet {
            updateColors()
        }
    }

    var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }

    var startLocation: Double = 0.05 {
        didSet {
            updateLocations()
        }
    }

    var endLocation: Double = 0.95 {
        didSet {
            updateLocations()
        }
    }

    var horizontalMode: Bool = false {
        didSet {
            updatePoints()
        }
    }

    var diagonalMode: Bool = false {
        didSet {
            updatePoints()
        }
    }

    override public class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer? {
        layer as? CAGradientLayer
    }

    func updatePoints() {
        if horizontalMode {
            gradientLayer?.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer?.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer?.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer?.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }

    func updateLocations() {
        gradientLayer?.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }

    func updateColors() {
        gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
}
