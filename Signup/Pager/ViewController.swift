//
//  ViewController.swift
//  Signup
//
//  Created by matan elimelech on 25/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var headerView: UIView!
    
    let numOfSteps = 4
    var curStep = 1
    var curPartOfSteps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stepsLabel.text = "Step \(curStep)"
        initCollectionView()
        changeProgressBar()
        
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile", "email", "user_friends"]
        btnFBLogin.delegate = self
        btnFBLogin.center = self.view.center
        self.view.addSubview(btnFBLogin)
        
        if FBSDKAccessToken.current() != nil {
            //
        }
        else {
            //
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initCollectionView() {
        stepsCollectionView.delegate = self
        stepsCollectionView.dataSource = self
        stepsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfSteps
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.initCell(UIView(), backgroundColor: indexPath.row%2 == 0 ? UIColor.green : UIColor.blue)
        return cell
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
            changeProgressBar()
            
        }
        if curStep < numOfSteps {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        if curStep < numOfSteps {
            curStep += 1
            stepsLabel.text = "Step \(curStep)"
            stepsCollectionView.scrollToItem(at: IndexPath.init(row: curStep - 1, section: 0), at: .centeredHorizontally, animated: true)
            changeProgressBar()
        }
        if curStep == numOfSteps{
            nextButton.setTitle("Finish", for: .normal)
        }
    }
    
    func changeProgressBar() {
        
        let allBarWidth = self.progressBarContainer.frame.width
        let widthOfPart = CGFloat(allBarWidth) / CGFloat(numOfSteps + 1)
        
        //self.progressBarContainer.subviews.forEach({ $0.removeFromSuperview() })
        
       let customView = UIView(frame: CGRect(x: 0 , y: 0, width: CGFloat(curStep) * widthOfPart, height: self.progressBarContainer.frame.height))
       customView.backgroundColor = UIColor.red
       self.progressBarContainer.addSubview(customView)
    }
}
