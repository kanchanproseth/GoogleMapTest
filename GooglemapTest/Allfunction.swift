//
//  Allfunction.swift
//  GooglemapTest
//
//  Created by Cyberk on 3/12/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import Alamofire



func getRecentData(_ lat: Double,_ long: Double){
    
    let url = "https://maps.googleapis.com/maps/api/geocode/json?&key=\(key)&latlng=\(lat)%2C\(long)"
    //  Mark 
    Alamofire.request(url).responseJSON { (response) in
        
        if let data = response.data {
            do {
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                print(jsonResult)
                
                if let json = jsonResult["results"] as? [Dictionary<String, AnyObject>]{
                    print(json)
                    if let address = json[0]["formatted_address"] as? String {
                        print(address)
                    }
                    if let currentPlaceid = json[0]["place_id"] as? String{
                        currentPlaceID = currentPlaceid
                    }
                    
                }
                
            } catch {
                print("JSON Processing Failed")
            }
            
        }
    }
}


//MARK fetchSearchresult
func getQuerySearchResultPlace(inputSearchText: String){
    
    let urlDirectionPlace = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=\(key)&input=coffeeshop\(inputSearchText)cambodia"
    
    //  Mark Popular Document
    Alamofire.request(urlDirectionPlace).responseJSON { (response) in
        
        if let data = response.data {
            do {
                //                    var AutoCompleteResults:[AutoCompleteResult] = []
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                print(json)
                var resultDescriptions = [String]()
                if let j: [Dictionary<String, AnyObject>] = json["predictions"] as? [Dictionary<String, AnyObject>] {
                    
                    for eachDescription in j{
                        let eachDescription = eachDescription as? [String:AnyObject]
                        let result = eachDescription?["description"] as? String
                        if !(eachDescription?["description"] is NSNull) {
                            
                            print("comeon\(result)")
//                            resultDescriptions.append(result!)
                        }
                        resultDescriptions.append(result!)
                    }
                    resultDescriptions.removeFirst()
                    arrResultAutoComplete = resultDescriptions
                    print("resultDescriptions\(resultDescriptions)")
                    
                }
                
            } catch {
                print("JSON Processing Failed")
            }
            
        }
    }
    
}



