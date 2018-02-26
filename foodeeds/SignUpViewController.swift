//
//  SignUpViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/23/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import Foundation
import AccountKit
import Firebase

import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate, AKFViewControllerDelegate
{
  
    @IBOutlet var usertext: UITextField!
    @IBOutlet weak var verifyOutlet: UIButton!
    var accountKit:AKFAccountKit!
 
    @IBAction func verifyButton(_ sender: UIButton)
    {
      if self.usertext.text == ""
        {
            self.usertext.placeholder = "Mandatory Field!"
        }
      else
      {
            let inputState: String = UUID().uuidString //it takes device ID
            
            let viewController:AKFViewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as! AKFViewController  //instance of the phone login screen to display
            
            viewController.delegate = self
            viewController.whitelistedCountryCodes = ["IN"]
            viewController.enableSendToFacebook = true //will send the code to facebook account
            
            self.prepareLoginViewController(viewController) //used to customize the theme of the facebook screen
            self.present(viewController as! UIViewController, animated: true, completion: nil)
       }
    }
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!)
    {
        print("Login Success with Access Token")
        accountKit?.requestAccount(
            {(account, error) in
                if let account = account
                {
                    if let phoneNo = account.phoneNumber
                    {
                        let userdefaults = UserDefaults.standard
                        userdefaults.set(phoneNo.phoneNumber, forKey: "Phone")
                        userdefaults.set(self.usertext.text, forKey: "Username")
                    }
                }
                else if let error = error
                {
                    
                }
        })
        DispatchQueue.main.async
            {
            self.performSegue(withIdentifier: "custom", sender: self)
            }
    }
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!)
    {
        print("Login Success With Authorization Code")
    }
    
    private func viewController(_ viewController: UIViewController!, didFailWithError error: NSError!)
    {
        print("We have an Error \(error)")
    }
    
    func viewControllerDidCancel(_ viewController: UIViewController!)
    {
        print("The user Cancelled the login")
    }
    
    func prepareLoginViewController(_ loginViewController:AKFViewController)
    {
        loginViewController.delegate = self
        loginViewController.advancedUIManager = nil
        
        let theme:AKFTheme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor.red
        theme.headerTextColor = UIColor.black
        theme.iconColor = UIColor.blue
        theme.inputTextColor = UIColor.clear
        theme.statusBarStyle = .default
        theme.textColor = UIColor.blue
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        sleep(3/2)
        usertext.isHidden = false
        usertext.isEnabled = true
        usertext.becomeFirstResponder()
        sleep(3/2)
        self.verifyOutlet.isHidden = false
        self.verifyOutlet.isEnabled = true
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        usertext.delegate = self
        usertext.isHidden = true
        usertext.isEnabled = false
        self.verifyOutlet.isHidden = true
        self.verifyOutlet.isEnabled = false
        
        if accountKit == nil
        {
            self.accountKit = AKFAccountKit(responseType: .accessToken)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
