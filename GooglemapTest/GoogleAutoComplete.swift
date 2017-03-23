//
//  GoogleAutoComplete.swift
//  GooglemapTest
//
//  Created by Cyberk on 3/23/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class GoogleAutoComplete: UIViewController {

    @IBOutlet weak var TextFieldSearchBar: UITextField!
    @IBOutlet weak var viewSearchBar: UIView!
    
    var ShowSearchResult:Bool?
    
    @IBOutlet weak var tableView: UITableView!
    
    var StartSearch : Bool?
    var arrFilter = [String]()
    var SearchData = [String]()
    var search:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "resultcell")
        TextFieldSearchBar.placeHolderColor = UIColor.white
        viewSearchBar.layer.cornerRadius = 5.0
        TextFieldSearchBar.layer.cornerRadius = 5.0
        ShowSearchResult = false
        
        tableView.delegate = self
        tableView.dataSource = self
        TextFieldSearchBar.delegate = self
        if let _arrResultAutoComplete = arrResultAutoComplete{
        SearchData = _arrResultAutoComplete
        }
        StartSearch = false
        TextFieldSearchBar.becomeFirstResponder()
//        getQuerySearchResultPlace(inputSearchText: <#T##String#>)
        
        // Do any additional setup after loading the view.
    }

}

extension GoogleAutoComplete: UITableViewDelegate, UITableViewDataSource{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultcell", for: indexPath) as! SearchResultCell
        cell.SearchResultDescriptionLabel.text = SearchData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension GoogleAutoComplete: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty
        {
            search = String(search.characters.dropLast())
            if search == ""{
                StartSearch = false
                SearchData = []
                tableView.isHidden = true
            }
        }
        else
        {
            tableView.isHidden = false
            ShowSearchResult = false
            search=TextFieldSearchBar.text!+string
            StartSearch = true
        }
        
        print(search)
        
        getQuerySearchResultPlace(inputSearchText: search)
        //        let predicate=NSPredicate(format: "SELF.name CONTAINS[cd] %@", search)
        //        let arr=(arrdata as NSArray).filtered(using: predicate)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func getQuerySearchResultPlace(inputSearchText: String){
        
        let urlDirectionPlace = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=\(key)&input=\(inputSearchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
        
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
                                resultDescriptions.append(result!)
                                print("comeon\(result)")
                                //                            resultDescriptions.append(result!)
                            }
                            
                        }
                        arrResultAutoComplete = resultDescriptions
                        print("resultDescriptions\(arrResultAutoComplete)")
                        let arr = arrResultAutoComplete?.filter({ (city) -> Bool in
                            let cText: NSString = city as NSString
                            
                            return (cText.range(of: self.search, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                        })
                        
                        if (arr?.count)! > 0
                        {
                            self.SearchData.removeAll(keepingCapacity: true)
                            self.SearchData = arr!
                        }
                        else
                        {
                        self.SearchData = arrResultAutoComplete!
                        }
                    }
                    
                } catch {
                    print("JSON Processing Failed")
                }
                
            }
        }
        
    }

    
}

