//
//  MapTask.swift
//  GooglemapTest
//
//  Created by Srey Oun on 3/10/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"

var selectedRoute: Dictionary<NSObject, AnyObject>!

var overviewPolyline: Dictionary<NSObject, AnyObject>!

var originCoordinate: CLLocationCoordinate2D!

var destinationCoordinate: CLLocationCoordinate2D!

var originAddress: String!

var destinationAddress: String!
