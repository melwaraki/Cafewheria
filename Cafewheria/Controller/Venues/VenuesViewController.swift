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
        let alertController = UIAlertController(title: "Feeling Lucky?", message: "We'll send you to a random coffee shop nearby. That is, only if you're feeling brave enough of course...", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Not Now", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Take Me There!", style: .default, handler: { _ in
            self.venues.filterToNearby().randomElement()?.openInMaps()
        }))
        alertController.view.tintColor = .systemPurple
        present(alertController, animated: true)
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
