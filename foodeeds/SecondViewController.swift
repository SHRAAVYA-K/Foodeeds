//
//  SecondViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/23/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import Firebase
class SecondViewController: UIViewController
{
    var ids = ["12345","23456","34567","45678","56789"]
    var name = ["Youth For Parivarthan","Happy Souls","Youth For Revolution","bngo","ango"]

     override func viewDidLoad()
     {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.prefersStatusBarHidden
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var orgid: UITextField!
    @IBOutlet weak var namename: UILabel!
    @IBOutlet weak var orgname: UILabel!
   
    @IBAction func verify(_ sender: UIButton)
    {
        for j in 0 ..< ids.count
        {
            if ids[j] == orgid.text
            {
                namename.text = "Name  :"
                orgname.text = name[j]
            }
        }
     
        for i in 0 ..< ids.count
        {
            if orgid.text == ids[i]
            {
                let success = UIAlertController(title: "Verification", message: "Successful!", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .cancel, handler: { (UIAlertAction) -> Void in
                    self.performSegue(withIdentifier: "vstocd", sender: self)
                })
                success.addAction(okay)
                self.present(success, animated: true, completion: nil)
            }
        }
        
        for i in 0 ..< ids.count
        {
            if orgid.text != ids[i]
            {
                let fail = UIAlertController(title: "Verification", message: "Please enter valid ID", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .cancel, handler: { (UIAlertAction) -> Void in
                })
                
                fail.addAction(okay)
                self.present(fail, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func skip(_ sender: UIButton)
    {
        let skip = UIAlertController(title: "Warning!", message: "Your claim shall be under donor's discretion.Foodeeds is not responsible for donor's decision or unauthentic claims.", preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .cancel) { (UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "vstocd", sender: self)
        }
        skip.addAction(okay)
        self.present(skip, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
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
