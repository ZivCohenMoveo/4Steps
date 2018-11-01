//
//  TextFieldModel.swift
//  Signup
//
//  Created by Ziv Cohen on 29/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import Foundation

protocol CitiesListDelegate: AnyObject {
    func citiesDidLoad(cities : [String])
}

// Logic of google autocomplete of cities

class GoogleAutocompleteViewModel: NSObject, AutoCompleteDelegate {
  
    var googleAutocomplete = GoogleAutocomplete()
    var cities = [String]()
    var selectedCity = ""
    var delegate : CitiesListDelegate!
    
    func valueChanged(_ value: String){
        googleAutocomplete.delegate = self
        googleAutocomplete.valueChange(value: value)
    }
    
    internal func autoComplete(_ addresses: [String]) {
        self.cities = addresses
        self.delegate.citiesDidLoad(cities: addresses)
    }
}
