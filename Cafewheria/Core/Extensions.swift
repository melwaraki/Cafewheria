//
//  Extensions.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import UIKit

enum ViewControllerState {
    case loading
    case error(message: String)
    case success
}

extension UIViewController {
    func presentErrorAlert(title: String = "Error", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.view.tintColor = .systemPurple
        present(alertController, animated: true)
    }
}

extension UIView {
    func addShadow(color: UIColor = .label) {
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}

extension Double {
    func toString() -> String? {
        return String(self)
    }
}
