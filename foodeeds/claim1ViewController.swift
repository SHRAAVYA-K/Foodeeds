//
//  claim1ViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 2/2/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class claim1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    var m:TimeInterval = 00
    var h:TimeInterval = 00
    var timer = Timer()
    var flag1:Int = 0
    var flag2 = [CGFloat]()
    var bit:String = ""
    var claim = [String]()
    var sec = 0
    var localityarray = [String]()
    var vnonvegarray = [String]()
    var servesarray = [String]()
    var exptimeHarray = [String]()
    var exptimeMarray = [String]()
    var phonenoarray = [String]()
    var currenttime = [String]()
    var selectedphoneno:String = ""

    var ref:FIRDatabaseReference!
    var userRef:FIRDatabaseReference!
    var appref:FIRDatabaseReference!
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.prefersStatusBarHidden
        ref=FIRDatabase.database().reference()
        self.appref = ref.child("AppData")
        appref.observe(.value, with: { (snapshot) in
            
            let data = snapshot.value as? [String:Any]
            if data != nil
            {
                for(key,value) in data!
                {
                    self.phonenoarray.append(key)
                    if let userdata = value as? [String:Any]
                    {
                        for(key,value) in userdata
                        {
                            if key == "AddressBit"
                            {
                                self.bit = userdata["AddressBit"] as! String
                            }
                            if self.bit == "T" && key == "TextFieldAddress"
                            {
                                let addRef = userdata["TextFieldAddress"] as! [String:Any]
                                if addRef["Locality"] as! String != ""
                                {
                                    self.localityarray.append(addRef["Locality"] as! String)
                                }                                
                            }
                                
                            else if self.bit == "D" && key == "DefaultAddress"
                            {
                                let addRef = userdata["DefaultAddress"] as! [String:Any]
                                if addRef["Locality"] as! String != ""
                                {
                                    self.localityarray.append(addRef["Locality"] as! String)
                                }
                                
                            }
                            
                        }
                    }
                }
                
                for(key,value) in data!
                {
                    self.appref = self.ref.child("AppData")
                    let userRef = self.appref.child(key)
                    if let userDetails = value as? [String:Any]
                    {
                        for (key, value) in userDetails
                        {
                            if key == "FoodDetails"
                            {
                                let foodRef = userDetails["FoodDetails"] as! [String:Any]
                                self.servesarray.append(foodRef["Serves"] as! String)
                                self.exptimeHarray.append(foodRef["ExpiryTimeH"] as! String)
                                self.exptimeMarray.append(foodRef["ExpiryTimeM"] as! String)
                                self.vnonvegarray.append(foodRef["VegNonveg"] as! String)
                            }
                        }
                    }
                }
            }
            self.tableview.reloadData()
        })
        
        // Do any additional setup after loading the view.
  }

    @IBOutlet weak var tableview: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return servesarray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? claim1TableViewCell
        cell?.locality.text = self.localityarray[indexPath.row]
        cell?.vnon.text = self.vnonvegarray[indexPath.row]
        cell?.serves.text = self.servesarray[indexPath.row]
        cell?.Expirytime.text = self.exptimeHarray[indexPath.row] + ":" + self.exptimeMarray[indexPath.row]
        
        if cell?.locality.text != "" && cell?.vnon.text != "" && cell?.serves.text != ""
        {
            cell?.bulletin.text = "."
        }
        else
        {
            cell?.bulletin.text = ""
        }
        
        self.ref = FIRDatabase.database().reference()
        self.appref = self.ref.child("AppData")
        appref.observe(.value, with: { (snapshot) in
            let data = snapshot.value as! [String:Any]
            if data != nil
            {
                for(key, value) in data
                {
                    let userData = value as? [String:Any]
                    for (key, value) in userData!
                    {
                        if key == "FoodDetails"
                        {
                            let foodData = value as? [String:Any]
                            for (key, value) in foodData!
                            {
                                if key == "Claim"
                                {
                                    if foodData?["Claim"] as? Int == 1
                                    {
                                        self.claim.append("Claimed")
                                        self.flag2.append(0.3)
                                    }
                                    else
                                    {
                                        self.claim.append("")
                                        self.flag2.append(1)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            cell?.claimedCellLabel.text = self.claim[indexPath.row]
            cell?.bulletin.alpha = self.flag2[indexPath.row]
            cell?.locality.alpha = self.flag2[indexPath.row]
            cell?.vnon.alpha = self.flag2[indexPath.row]
            cell?.serves.alpha = self.flag2[indexPath.row]
            cell?.Expirytime.alpha = self.flag2[indexPath.row]
        })
        
        return cell!
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc : claim2ViewController = segue.destination as!claim2ViewController
        dvc.p = self.selectedphoneno
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectedphoneno = self.phonenoarray[indexPath.row]
        self.performSegue(withIdentifier: "c1toc2", sender: self)
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
