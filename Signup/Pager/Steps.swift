//
//  Steps.swift
//  Signup
//
//  Created by Ziv Cohen on 28/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import Foundation
import UIKit

class Steps {
    
    var allSteps : [UIView] = []
    let colorsArray = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.black]
    
    func initStepsView() -> [UIView]{
        for index in 0...colorsArray.count - 1{
            let view = UIView()
            view.backgroundColor = colorsArray[index]
            self.allSteps.append(view)
        }
        return self.allSteps
    }
}
