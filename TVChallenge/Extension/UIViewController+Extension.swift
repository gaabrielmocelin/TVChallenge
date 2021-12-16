//
//  UIViewController+Extension.swift
//  TVChallenge
//
//  Created by Gabriel Mocelin on 15/12/21.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String? = nil, message: String? = nil, actions: [AlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        actions
            .map { UIAlertAction(title: $0.title, style: $0.style, handler: $0.action) }
            .forEach { alert.addAction($0) }

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let action: (UIAlertAction) -> Void
}
