
//  TextFieldView.swift
//  Signup

//  Created by Ziv Cohen on 28/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.


import UIKit
import GoogleMaps
import GooglePlaces

class TextFieldView: UIView, UITextFieldDelegate, CitiesListDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var contentView: TextFieldView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var citiesTableView: UITableView!
    
    fileprivate var googleAutocomplete = GoogleAutocomplete()
    fileprivate var textFieldModel = TextFieldModel()
    fileprivate var citiesToShow = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
    
        Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textField.delegate = self
        textFieldModel.delegate = self
        
    }
    
    @IBAction func textFieldEditingChange(_ sender: Any) {
        
        if let value = self.textField.text {
            if value != "" {
                self.textFieldModel.valueChanged(value)
            }
            else {
                removeTable()
            }
        }
    }
    
    func citiesDidLoad(cities: [String]) {
        
        if !cities.isEmpty {
            self.citiesToShow = cities
            initCitiesTableView()
        }
        else {
            removeTable()
        }
    }
    
    func initCitiesTableView() {
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesTableView.register(UINib(nibName: CITY_TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: CITY_TABLE_VIEW_CELL)
        
    
        UIView.transition(with: citiesTableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {self.citiesTableView.alpha = 1
                            self.citiesTableView.reloadData() })
    }
    
    func removeTable() {
        
        UIView.transition(with: citiesTableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {self.citiesTableView.alpha = 0
                            self.citiesTableView.reloadData() })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFieldModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CITY_TABLE_VIEW_CELL, for: indexPath) as! CitiesTableViewCell
        cell.initCell(text: textFieldModel.cities[indexPath.row])
        return cell
    }
}
