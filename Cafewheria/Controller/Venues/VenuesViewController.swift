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
    
    var locationManager: CLLocationManager!
    var toggleableViews: [UIView] = []
    
    var venues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        toggleableViews = [activityIndicatorView, emptyScreenLabel, toggleLocationButton, tableView]
    }
    
    @IBAction func tappedToggleLocationButton(_ sender: Any) {
        guard let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/") else {
            return
        }
        
        UIApplication.shared.open(url)
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
            hideAll(except: [tableView])
        }
    }
    
    func hideAll(except views: [UIView]) {
        for toggleableView in toggleableViews {
            toggleableView.isHidden = !views.contains(toggleableView)
        }
    }
    
    
}
