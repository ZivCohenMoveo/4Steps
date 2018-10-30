//
//  CitiesTableViewCell.swift
//  Signup
//
//  Created by Ziv Cohen on 30/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import UIKit

let CITY_TABLE_VIEW_CELL = "CitiesTableViewCell"

class CitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var citiesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(text: String) {
        self.citiesLabel.text = text
    }
    
}
