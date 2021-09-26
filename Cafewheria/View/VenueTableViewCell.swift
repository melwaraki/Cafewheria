//
//  VenueTableViewCell.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 27/09/2021.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    
    func setup(with venue: Venue) {
        distanceLabel.text = venue.kmDistanceString
        venueNameLabel.text = venue.name
    }

}
