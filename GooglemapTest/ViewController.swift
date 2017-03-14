//
//  ViewController.swift
//  GooglemapTest
//
//  Created by Cyberk on 3/9/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import ObjectMapper


class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
//        getQuerySearchResultPlace(inputSearchText: "watphnom")
        placesClient = GMSPlacesClient.shared()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchAutocomplete(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        filter.country = "KH"
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
        }
    
    func showMapView(_ latitude:Double,_ longitude:Double){
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoomLevel)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
        
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations.last! as CLLocation
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        print(lat)
        print(long)
        LATITUDE = lat
        LONGITUDE = long
        //Do What ever you want with it
        showMapView(LATITUDE, LONGITUDE)
        
//        getRecentData(lat, long)
        //        var ceo = CLGeocoder()
        //        var loc = CLLocation(latitude: lat  , longitude: long)
        //        //insert your coordinates
        //        ceo.reverseGeocodeLocation(loc, completionHandler:
        //            { ( placemarks,error) -> Void in
        //                var placemark: CLPlacemark? = placemarks?[0]
        //                if placemark != nil {
        //                    print("placemark \(placemark)")
        //                    //String to hold address
        //
        //                    print("addressDictionary \(placemark?.addressDictionary)")
        //                    print("placemark1 \(placemark?.region)")
        //                    print("placemark2 \(placemark?.country)")
        //                    // Give Country Name
        //                    print("placemark3 \(placemark?.locality)")
        //                    // Extract the city name
        //                    print("location4 \(placemark?.name)")
        //                    print("location5 \(placemark?.ocean)")
        //                    print("location6 \(placemark?.postalCode)")
        //                    print("location7 \(placemark?.subLocality)")
        //                    print("location8 \(placemark?.location)")
        //                    //Print the location to console
        ////                    print("I am currently at \(locatedAt)")
        //                }
        //                else {
        //                    print("Could not locate")
        //                }
        //        }
        //        )
        
    }
    
 

}






extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        navigationController?.navigationItem.title = "\(place.name)"
        print("Place address: \(place.formattedAddress)")
//        place.placeID
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
        
        DESTLATITUDE = place.coordinate.latitude
        DESTLONGITUDE = place.coordinate.longitude
        let showDestVC = showDestinationVC()
        present(showDestVC, animated: false, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}










//var cameraPosition = GMSCameraPosition.camera(withLatitude: 18.5203, longitude: 73.8567, zoom: 12)
//self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: cameraPosition)
//self.mapView.myLocationEnabled = true
//var marker = GMSMarker()
//marker.position = CLLocationCoordinate2DMake(18.5203, 73.8567)
//marker.icon = UIImage(named: "aaa.png")
//marker.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
//marker.map = self.mapView
//var path = GMSMutablePath.path
//path?.addCoordinate(CLLocationCoordinate2DMake(CDouble((18.520)), CDouble((73.856))))
//path?.addCoordinate(CLLocationCoordinate2DMake(CDouble((16.7)), CDouble((73.8567))))
//var rectangle = GMSPolyline(path)
//rectangle.strokeWidth = 2.0
//rectangle.map = self.mapView
//self.view = self.mapView


