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


class ViewController: UIViewController, CLLocationManagerDelegate , GMSMapViewDelegate{
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    
    
    @IBOutlet weak var MyView: UIView!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func searchAutocomplete(_ sender: Any) {
//        let autocompleteController = GMSAutocompleteViewController()
//        autocompleteController.delegate = self
//        let filter = GMSAutocompleteFilter()
//        filter.type = .city
//        filter.country = "KH"
//        autocompleteController.autocompleteFilter = filter
//        present(autocompleteController, animated: true, completion: nil)
        let GoogleAutoCompletevc = GoogleAutoComplete(nibName: "GoogleAutoComplete", bundle: nil)
        GoogleAutoCompletevc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        GoogleAutoCompletevc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(GoogleAutoCompletevc, animated: true, completion: nil)
        }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations.last! as CLLocation
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        print(lat)
        print(long)
        LATITUDE = lat
        LONGITUDE = long
        locationManager.stopUpdatingLocation()
        showMapView(LATITUDE, LONGITUDE)
    }
    
    
    
    func showMapView(_ latitude:Double,_ longitude:Double){
        
        let camera = GMSCameraPosition.camera(withLatitude: LATITUDE, longitude: LONGITUDE, zoom: zoomLevel)
        let mapView = GMSMapView.map(withFrame: MyView.bounds, camera: camera)
        mapView.settings.setAllGesturesEnabled(true)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.delegate = self
        MyView.addSubview(mapView)
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        mapView.clear()
        let originMarker = GMSMarker()
        originMarker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        originMarker.map = mapView
        originMarker.icon = GMSMarker.markerImage(with: UIColor.black)
        originMarker.title = originAddress
    }

    
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        print("markerInfoWindow")
//        return self.view
//    }
//    
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        
//    }


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



//func gotoMyLocationAction(sender: UIButton)
//{
//    guard let lat = self.mapView.myLocation?.coordinate.latitude,
//        let lng = self.mapView.myLocation?.coordinate.longitude else { return }
//    
//    let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: zoom)
//    self.mapView.animate(to: camera)
//}



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


