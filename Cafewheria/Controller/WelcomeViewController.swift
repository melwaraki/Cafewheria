//
//  WelcomeViewController.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 27/09/2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var onDismissal: (() -> Void)?
    
    @IBAction func tappedContinue(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: Constants.SettingsKey.seenWelcomeScreen.rawValue)
        onDismissal?()
        dismiss(animated: true)
    }
}
