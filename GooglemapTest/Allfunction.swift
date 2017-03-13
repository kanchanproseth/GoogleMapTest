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
    
    let key = "AIzaSyCgFAmCSFQeqjxS-HtXBZCmgpDanb0yw3U"
    
    let url = "https://maps.googleapis.com/maps/api/geocode/json?&key=\(key)&latlng=\(lat)%2C\(long)"
    //  Mark Popular Document
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
    
    let key = "AIzaSyCgFAmCSFQeqjxS-HtXBZCmgpDanb0yw3U"
    
    let urlDirectionPlace = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=\(key)&input=\(inputSearchText)cambodia"
    
    //  Mark Popular Document
    Alamofire.request(urlDirectionPlace).responseJSON { (response) in
        
        if let data = response.data {
            do {
                //                    var AutoCompleteResults:[AutoCompleteResult] = []
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                print(json)
                let model = AutoCompleteResult()
                var resultDescriptions = [model.description]
                if let j: [Dictionary<String, AnyObject>] = json["predictions"] as? [Dictionary<String, AnyObject>] {
                    
                    for eachDescription in j{
                        let eachDescription = eachDescription as? [String:AnyObject]
                        let result = eachDescription?["description"] as? String
                        if !(eachDescription?["description"] is NSNull) {
                            
                            print("comeon\(result)")
                            //                                resultDescriptions.append(result!)
                        }
                        resultDescriptions.append(result!)
                    }
                    resultDescriptions.removeFirst()
                    print("resultDescriptions\(resultDescriptions)")
                    
                }
                
                
                
                
                //                    if let json = jsonResult["predictions"] as? [Dictionary<String, AnyObject>]{
                //                        print(json)
                //                        for eachDescription in json{
                //                            let eachDescription = eachDescription
                //                            let model = AutoCompleteResult()
                //                            if !(eachDescription["ID"] is NSNull)  {
                //                            model.resultDescription = eachDescription["description"] as? String
                //                            }
                //                            AutoCompleteResults.append(model)
                //                            print("testingresult\(AutoCompleteResults)")
                //
                //                        }
                //
                //                    }
                
            } catch {
                print("JSON Processing Failed")
            }
            
        }
    }
    
}



