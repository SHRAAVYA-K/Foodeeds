//
//  claim2ViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 2/2/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import CoreData
class claim2ViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet weak var table: UITableView!
    var sec = 0
    var p:String?
    var fooddetaills1:NSArray?
    var ref:FIRDatabaseReference!
    var userRef:FIRDatabaseReference!
    var appref:FIRDatabaseReference!
    var itemsArray = [String]()
    var itemArray:[String] = [""]
    var qtyArray:[String] = [""]
    var foodref:FIRDatabaseReference!
    var itemCount = 0
    var itemstr = ""
    var qtystr = ""
    var itemstrcount:Int = 0
    var dispitem:String = ""
    var dispqty:String = ""
    var addbit = ""
    
    @IBOutlet weak var ClaimedLabel: UILabel!
    @IBOutlet weak var claimbutton: UIButton!
    var claim:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        phone.delegate = self
        self.phone.text = p
        self.ClaimedLabel.isHidden = true
    }
    
    func retrieve(completion: @escaping (Bool) -> (Bool))
    {
        self.ref = FIRDatabase.database().reference()
        self.appref = ref.child("AppData")
        self.userRef = appref.child(self.phone.text!)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [String:Any]
            if data != nil
            {
                for(key, value) in data!
                                {
                                    if key == "FoodDetails"
                                    {
                                        if let foodData = value as? [String:Any]
                                        {
                                            self.itemCount = foodData["ItemCount"] as! Int
                                            for(key,value) in foodData
                                            {
                                                if let item = value as? [String]
                                                {
                                                    for i in 0..<self.itemCount
                                                    {
                                                        self.itemsArray.append((item[i] as? String)!)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                for (key,value) in data!
                {
                    if key == "UserDetails"
                    {
                        let username = value as? [String:Any]
                        self.uname.text = username?["Username"] as! String
                    }
                    
                    if key == "AddressBit"
                    {
                        let addressbit = value as? String
                        if addressbit == "D"
                        {
                            self.addbit = "D"
                        }
                        else if addressbit == "T"
                        {
                            self.addbit = "T"
                        }
                    }
                    
                    if key == "DefaultAddress" && self.addbit == "D"
                    {
                        let defadd = value as? [String:Any]
                        var city = defadd?["City"] as! String
                        var door = defadd?["Door"] as! String
                        var street = defadd?["Street"] as! String
                        var locality = defadd?["Locality"] as! String
                        var pincode = defadd?["State"] as! String
                        
                        self.address.text = door + "\n" + street + "\n" + locality + "\n" + city + "\n" + pincode
                    }
                    
                    if key == "TextFieldAddress" && self.addbit == "T"
                    {
                        let textadd = value as? [String:Any]
                        var city = textadd?["City"] as! String
                        var door = textadd?["Door"] as! String
                        var street = textadd?["Street"] as! String
                        var locality = textadd?["Locality"] as! String
                        var pincode = textadd?["State"] as! String
                        self.address.text = door + "\n" + street + "\n" + locality + "\n" + city + "\n" + pincode
                    }
                }
            }
            completion(true)
        })
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return false
    }
    
    @IBOutlet weak var uname: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? claim2TableViewCell

        retrieve {success in
            if success{
                self.abc()
                for i in self.itemstr.characters.indices[self.itemstr.startIndex..<self.itemstr.endIndex]
                {
                    if self.itemstr[i] == "."
                    {
                        self.dispitem.append("\n")
                    }
                    else
                    {
                        self.dispitem.append(self.itemstr[i])
                        cell?.item.text = self.dispitem
                    }
                }
                
                for i in self.qtystr.characters.indices[self.qtystr.startIndex..<self.qtystr.endIndex]
                {
                    if self.qtystr[i] == "."
                    {
                        self.dispqty.append("\n")
                    }
                    else
                    {
                        self.dispqty.append(self.qtystr[i])
                        cell?.qty.text = self.dispqty
                    }
                }
            }
            return true
        }
        return cell!
    }
 
    @IBAction func claim(_ sender: UIButton)
    {
        let a = UIAlertController(title: "FOODEEDS!", message: "\nYOUR CLAIM IS SUCCESSFUL.\nTHANK YOU!\n\n* Foodeeds is not responsible for collection or delivery of food.", preferredStyle: .alert)
        
        let b = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) -> Void in
           
            self.claim = 1
            
            if self.claim == 1
            {
                self.ref = FIRDatabase.database().reference()
                self.appref = self.ref.child("AppData")
                self.userRef = self.appref.child(self.phone.text!)
                self.foodref = self.userRef.child("FoodDetails")
                
                let claimdata = ["Claim":1]
                self.foodref.updateChildValues(claimdata)
            }
            
            self.tabBarController?.selectedIndex = 2
             self.navigationController?.popToRootViewController(animated: true)
        }
        
        let c = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            
        }
        
        a.addAction(b)
        a.addAction(c)
        self.present(a, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.ref = FIRDatabase.database().reference()
        self.appref = self.ref.child("AppData")
        self.userRef = self.appref.child(self.phone.text!).child("FoodDetails")
        userRef.observe(.value, with: { (snapshot) in
            let data = snapshot.value as! [String:Any]
            if data != nil
            {
                for(key, value) in data
                {
                    if key == "Claim"
                    {
                        let claimData = value as? Int
                        self.claim = claimData!
                    }
                }
            }
            if self.claim == 1
            {
                self.claimbutton.isHidden = true
                self.claimbutton.isEnabled = false
                self.ClaimedLabel.isHidden = false
            }
        })
    }
    
    func abc() -> Void
    {
        if self.itemCount > 1
        {
            for i in 0..<self.itemCount-1
            {
                self.itemsArray[0] += "." + self.itemsArray[i+1]
            }
        }

        for i in self.itemCount..<self.itemsArray.count
        {
            self.qtyArray[0] += self.itemsArray[i] + "."
        }

        self.itemstr = self.itemsArray[0]
        self.itemstrcount = self.itemstr.characters.count
        self.qtystr = self.qtyArray[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
