//
//  VenuesViewController+UITableView.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import UIKit

extension VenuesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return venues.filterToNearby().count
        } else {
            return venues.filterToFar().count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Nearby"
        } else {
            return "Others"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCell(at: indexPath)
    }
    
    // for testing purposes
    func getCell(at indexPath: IndexPath, with mockVenues: [Venue]? = nil) -> UITableViewCell {
        let venues = mockVenues ?? self.venues
        let filteredVenues = indexPath.section == 0 ? venues.filterToNearby() : venues.filterToFar()
        let venue = filteredVenues[indexPath.item]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = venue.name
        cell.detailTextLabel?.text = venue.kmDistanceString
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        venues[indexPath.row].openInMaps()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
