//
//  PictureModel.swift
//  Signup
//
//  Created by Ziv Cohen on 01/11/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import Foundation

struct Picture {

    var data : Data
}

struct Data {
    
    var height : Int
    var width : Int
    var is_silhouette : Bool
    var url : String
}
