//
//  showDestinationVC.swift
//  GooglemapTest
//
//  Created by Cyberk on 3/13/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class showDestinationVC: UIViewController {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentLoc = CLLocationCoordinate2D(latitude: LATITUDE, longitude: LONGITUDE)
        let destinationloc = CLLocationCoordinate2D(latitude: DESTLATITUDE, longitude: DESTLONGITUDE)
        getPolylineRoute(from: currentLoc, to: destinationloc)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        let url = "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving"
        Alamofire.request(url).responseJSON { (response) in
            
            if let data = response.data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    
                    let routes = json["routes"] as? [Dictionary<String, AnyObject>]
                    print(routes)
                    let overview_polyline = routes?[0]["overview_polyline"] as? [String:Any]
                    print(overview_polyline)
                    let polyString = overview_polyline?["points"] as?String
                    print(polyString)
                    DispatchQueue.main.async {
                        self.pointtwoMarker(source, destination, polyString!)
                        
                    }
                } catch {
                    print("JSON Processing Failed")
                }
                
            }
        }
    }
    
    func pointtwoMarker(_ source: CLLocationCoordinate2D, _ destination: CLLocationCoordinate2D, _ polyString: String){
        
        let camera = GMSCameraPosition.camera(withTarget: source, zoom: zoomLevel)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        mapView.settings.myLocationButton = true
//        mapView.isMyLocationEnabled = true
        
        let originMarker = GMSMarker()
        originMarker.position = source
        originMarker.map = mapView
        originMarker.icon = GMSMarker.markerImage(with: UIColor.red)
        originMarker.title = originAddress
        
        //
        let destinationMarker = GMSMarker()
        destinationMarker.position = destination
        destinationMarker.map = mapView
        destinationMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        destinationMarker.title = destinationAddress
        
        let path = GMSPath(fromEncodedPath: polyString)
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
        polyline.strokeColor = UIColor.red
        polyline.strokeWidth = 3.0
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
