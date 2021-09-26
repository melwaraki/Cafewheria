//
//  VenuesViewController.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import UIKit
import CoreLocation

class VenuesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emptyScreenLabel: UILabel!
    @IBOutlet weak var toggleLocationButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feelingLuckyButton: UIButton!
    
    var locationManager: CLLocationManager!
    var toggleableViews: [UIView] = []
    
    var venues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleableViews = [activityIndicatorView, emptyScreenLabel, toggleLocationButton, tableView, feelingLuckyButton]
        setupLocationManager()
        decorateInterface()
    }
    
    @IBAction func tappedToggleLocationButton(_ sender: Any) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    @IBAction func tappedFeelingLucky(_ sender: Any) {
        presentErrorAlert(message: "You're in early")
    }
    
    func decorateInterface() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        feelingLuckyButton.addShadow()
    }
    
    var state: ViewControllerState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.updateViewController()
            }
        }
    }
    
    func updateViewController() {
        switch state {
        case .loading:
            activityIndicatorView.startAnimating()
            emptyScreenLabel.text = "Finding your nearest coffee shops..."
            hideAll(except: [activityIndicatorView, emptyScreenLabel])
        case .error(let message):
            activityIndicatorView.stopAnimating()
            emptyScreenLabel.text = message
            var viewsToShow: [UIView] = [emptyScreenLabel]
            if locationManager.authorizationStatus == .denied {
                viewsToShow.append(toggleLocationButton)
            }
            hideAll(except: viewsToShow)
        case .success:
            activityIndicatorView.stopAnimating()
            tableView.reloadData()
            hideAll(except: [tableView, feelingLuckyButton])
        }
    }
    
    func hideAll(except views: [UIView]) {
        for toggleableView in toggleableViews {
            toggleableView.isHidden = !views.contains(toggleableView)
        }
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
