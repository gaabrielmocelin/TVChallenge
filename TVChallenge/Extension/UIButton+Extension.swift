//
//  UIButton+Extension.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 16/12/21.
//

import UIKit

extension UIButton {
    func addBlurEffect(style: UIBlurEffect.Style = .regular, cornerRadius: CGFloat = 0, padding: CGFloat = 0) {
        backgroundColor = .clear
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurView.isUserInteractionEnabled = false
        blurView.backgroundColor = .clear

        if cornerRadius > 0 {
            blurView.layer.cornerRadius = cornerRadius
            blurView.layer.masksToBounds = true
        }

        insertSubview(blurView, at: 0)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -padding).isActive = true
        topAnchor.constraint(equalTo: blurView.topAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -padding).isActive = true

        if let imageView = imageView {
            imageView.backgroundColor = .clear
            bringSubviewToFront(imageView)
        }
    }
}
