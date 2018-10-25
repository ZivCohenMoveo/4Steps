//
//  ViewController.swift
//  Signup
//
//  Created by matan elimelech on 25/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let numOfSteps = 4
    var curStep = 1
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stepsLabel.text = "Step \(curStep)"
        
        initCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initCollectionView() {
    
        stepsCollectionView.delegate = self
        stepsCollectionView.dataSource = self
        
        stepsCollectionView.register(UINib(nibName: RED_CELL, bundle: nil), forCellWithReuseIdentifier: RED_CELL)
        stepsCollectionView.register(UINib(nibName: BLUE_CELL, bundle: nil), forCellWithReuseIdentifier: BLUE_CELL)
        stepsCollectionView.register(UINib(nibName: GREEN_CELL, bundle: nil), forCellWithReuseIdentifier: GREEN_CELL)
        stepsCollectionView.register(UINib(nibName: BLACK_CELL, bundle: nil), forCellWithReuseIdentifier: BLACK_CELL)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfSteps
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RED_CELL, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BLUE_CELL, for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GREEN_CELL, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BLACK_CELL, for: indexPath)
            return cell
        }
    }

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        if curStep > 1 {
            curStep -= 1
            stepsLabel.text = "Step \(curStep)"
            
            stepsCollectionView.scrollToItem(at: IndexPath.init(row: curStep - 1, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        if curStep < numOfSteps {
            curStep += 1
            stepsLabel.text = "Step \(curStep)"
            
            stepsCollectionView.scrollToItem(at: IndexPath.init(row: curStep - 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
}

