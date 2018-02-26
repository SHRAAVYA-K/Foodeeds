//
//  ThirdViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/23/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import Firebase

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var g = [String]()
    var k = [String]()
    var unamearray = [String]()
    var ref:FIRDatabaseReference!
    var socialRef:FIRDatabaseReference!
    var userref:FIRDatabaseReference!
    var usernameref:FIRDatabaseReference!
    var pno:String!
    var a:Int = 0
    var z:String = ""
    var username:String = ""
    @IBOutlet var tableview: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        let defaults = UserDefaults.standard
        self.username = defaults.value(forKey: "Username")  as! String
        self.pno = defaults.value(forKey: "Phone") as! String
    
        socialRef = self.ref.child("Social")
        userref = socialRef.child(self.pno)
        usernameref = userref.child(self.username)
        usernameref.observe(.value, with: { (snapshot) in
            let data = snapshot.value as? [String]
            if data != nil
            {
                self.k.removeAll()
                for (index,element) in (data?.enumerated())!
                {
                    self.k.append((data?[index])!)
                }
            }
            self.tableview.reloadData()
        })
        socialRef.observe(.value, with: { (snapshot) in
            
            let data = snapshot.value as? [String:Any]
            if data != nil
            {
                self.g.removeAll()
                self.unamearray.removeAll()
                for (key,value) in data!
                {
                    let socialdata = value as! [String:Any]
                    for(key, value) in socialdata
                    {
                        let comments = value as! [String]
                        for (index,element) in comments.enumerated()
                        {
                            self.unamearray.append(key)
                            self.g.append(comments[index])
                        }
                    }
                }
            }
            self.tableview.reloadData()

        })
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var exp: UITextField!
    @IBAction func submit(_ sender: UIButton)
    {
        if (exp.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count)! != 0
        {
            let textField =  self.exp.text!
            self.k.append(textField)
            exp.text = ""
            exp.placeholder = "Enter your experience here!"
            
            socialRef = self.ref.child("Social")
            userref = socialRef.child(self.pno)
            let childupdates = [self.username:self.k]
            userref.updateChildValues(childupdates)
        }
    }
 
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return g.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as? SocialCellTableViewCell
        cell?.labels.text = self.g[indexPath.row]
        cell?.username.text = "- " + self.unamearray[indexPath.row]
        return cell!
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
