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
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager: CLLocationManager!
    var venues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocation()
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
        case .error:
            activityIndicatorView.stopAnimating()
            emptyScreenLabel.text = "Couldn't load nearby coffee shops"
            hideAll(except: [emptyScreenLabel])
        case .success:
            activityIndicatorView.stopAnimating()
            tableView.reloadData()
            hideAll(except: [tableView])
        }
    }
    
    func hideAll(except views: [UIView]) {
        for loopedView in [activityIndicatorView, emptyScreenLabel, tableView] {
            loopedView?.isHidden = !views.contains(loopedView!)
        }
    }
    
    func checkLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        updateViewController()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}
