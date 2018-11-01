//
//  ViewController.swift
//  Signup
//
//  Created by matan elimelech on 25/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

// Home Page controller- has collectionView, header with progress bar, facebook login and autocomplete textField
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userDetails: UILabel!
    
    
    let numOfSteps = 4
    var curStep = 1
    var curPartOfSteps = 0
    var customView : UIView!
    var allBarWidth : CGFloat = 0.0
    var widthOfPart : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stepsLabel.text = "Step \(curStep)"
        initCollectionView()
        setProgressBar()
        
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile", "email", "user_friends"]
        btnFBLogin.delegate = self
        btnFBLogin.center = self.view.center
        self.view.addSubview(btnFBLogin)
        
        if FBSDKAccessToken.current() != nil {
            fetchUserProfile()
        }
        else {
            userDetails.text = ""
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if FBSDKAccessToken.current() != nil {
            fetchUserProfile()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        userDetails.text = ""
    }
    
    func fetchUserProfile()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error took place: \(String(describing: error))")
            }
            else
            {
                print("Print entire fetched result: \(String(describing: result))")
                let fbDetails = result as! NSDictionary
            
                let user = User(email: fbDetails["email"] as! String,
                                id: fbDetails["id"] as! String,
                                name: fbDetails["name"] as! String)
                print(user)
                self.userDetails.text = user.email
            }
        })
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
            setProgressBar()
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
            setProgressBar()
        }
        if curStep == numOfSteps{
            nextButton.setTitle("Finish", for: .normal)
        }
    }
    
    func setProgressBar() {
        
        if let viewToRemove = self.customView {
            viewToRemove.removeFromSuperview()
        }
        
        allBarWidth = self.progressBarContainer.frame.width
        widthOfPart = CGFloat(allBarWidth) / CGFloat(numOfSteps + 1)
        self.customView = UIView(frame: CGRect(x: 0 , y: 0, width: CGFloat(curStep) * widthOfPart, height: self.progressBarContainer.frame.height))
        self.customView.backgroundColor = UIColor.red
        self.progressBarContainer.addSubview(self.customView)
    }
}
