//
//  Lanes.swift
//  Hot Lanes
//
//  Created by Datta on 10/15/16.
//  Copyright © 2016 dvapps. All rights reserved.
//

import UIKit
import MapKit
class Lanes: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
