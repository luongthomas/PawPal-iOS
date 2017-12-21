//
//  Artwork.swift
//  PawPal
//
//  Created by Puroof on 12/20/17.
//  Copyright © 2017 PawPal. All rights reserved.
//

import MapKit


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let disciple: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, disciple: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.disciple = disciple
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
