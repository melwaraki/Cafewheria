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
        present(alertController, animated: true)
    }
}

extension Double {
    func toString() -> String? {
        return String(self)
    }
}
