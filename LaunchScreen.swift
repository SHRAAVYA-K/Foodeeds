//
//  LaunchScreen.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/24/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit

class LaunchScreen: UIViewController
{
    //var c = 0
    
    @IBOutlet var continuebutton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    //    self.ambutton.enabled = false
     //   self.supbutton.enabled = false
        // Do any additional setup after loading the view.
    
        continuebutton.isHidden = true
        continuebutton.isEnabled = false
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(2)
        continuebutton.isHidden = false
        continuebutton.isEnabled = true
        

    }
    
 //   @IBOutlet var conbutton: UIButton!
  //  @IBOutlet weak var con: UILabel!
  ////  @IBOutlet weak var am: UILabel!
   // @IBOutlet weak var sup: UILabel!
   //// @IBOutlet var ambutton: UIButton!
    //@IBOutlet var supbutton: UIButton!
    
//    @IBAction func supbutton(sender: AnyObject)
 //   {
        //self.supbutton.enabled = true
 //   }
    
  //  @IBAction func ambutton(sender: AnyObject)
  //  {
        //self.ambutton.enabled = true
  //  }
    
  //  @IBAction func `continue`(sender: UIButton)
   // {
   //     sleep(3/4)
       // c=1
      ///  if c==1
       // {
           // self.conbutton.enabled = false
         //   self.supbutton.enabled = true
         //   self.ambutton.enabled = true
          //  self.sup.text = "Sign Up"
      //      self.am.text = "Already a member?"
      //      self.con.hidden = true
     //   }
   // }
    
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
