//
//  GoogleAutocomplete.swift
//  Signup
//
//  Created by Ziv Cohen on 29/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol AutoCompleteDelegate : AnyObject {
    func autoComplete(_ addresses : [String])
}

// google places api- autocomplete of cities
class GoogleAutocomplete: NSObject {
   
    var delegate : AutoCompleteDelegate?
    fileprivate let ApiKey = "AIzaSyC3I1_r9DaRh204EYwVL-rd0AAui4ei4t0"
    fileprivate let GoogleMapsbaseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    let numOfOptions = 4
    
    func valueChange(value: String) {
        
        let urlString = GoogleMapsbaseURL + "?key=" + ApiKey  + "&input="  + value + "&types=(cities)"
        var addresses = [String]()
        let s = NSCharacterSet.urlQueryAllowed as! NSMutableCharacterSet
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: s as CharacterSet) {
            Alamofire.request(encodedString, method: .get, parameters:nil).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if json["status"].stringValue == "OK" {
                        let predictions = json["predictions"].arrayValue
                        for item in predictions {
                            addresses.append(item["description"].stringValue)
                            if addresses.count >= self.numOfOptions {
                                break
                            }
                        }
                    }
                    self.delegate?.autoComplete(addresses)
                case .failure(_):
                    self.delegate?.autoComplete(addresses)
                }
            }
        }
    }
}
