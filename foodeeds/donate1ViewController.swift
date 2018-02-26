//
//  donate1ViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/30/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import CoreData
import  Firebase
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

class donate1ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet var adcel: UIButton!
    var ref:FIRDatabaseReference!
    var foodRef:FIRDatabaseReference!
    var userRef:FIRDatabaseReference!
    var appref:FIRDatabaseReference!
    var itemRef:FIRDatabaseReference!
    var qtyRef:FIRDatabaseReference!
    var VNon:String!
    var itemName:String!
    var itemData:[String]=[]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        let defaults = UserDefaults.standard
        self.passphone.text = defaults.value(forKey: "Phone") as! String?
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.prefersStatusBarHidden
        self.cfrm.isEnabled = false
        serves.placeholder = "Approx."
        hours.delegate = self
        mins.delegate = self
        adcel.layer.cornerRadius = adcel.frame.size.width/2
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var passphone: UILabel!
    @IBOutlet weak var vnonveg: UISegmentedControl!
    @IBOutlet weak var serves: UITextField!
    @IBOutlet var cfrm: UIButton!
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var mins: UITextField!
    @IBOutlet weak var fdtv: UITableView!
    var itemArray = [String]()
    var qtyArray = [String]()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var minsString = ""
        if mins.text != nil
        {
            minsString += mins.text!
        }
        
        minsString += string
        let limitNumber = Int(minsString)
        if limitNumber <= 60
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? CustomTableViewCell
        cell?.item.text = self.itemArray[indexPath.row]
        cell?.quantity.text = self.qtyArray[indexPath.row]
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
   @IBAction func addCell(_ sender: AnyObject)
   {
        let alertController = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)    
        alertController.addTextField(
            configurationHandler: { (itm) -> Void in
               itm.placeholder = "Item"
               
            } )
    
        alertController.addTextField(
        configurationHandler: { (qty) -> Void in
            qty.placeholder = "Quantity"
            qty.keyboardType = UIKeyboardType.numberPad
        } )
    
        let addAction = UIAlertAction(title: "ADD", style: .default)
        { [weak self] (action: UIAlertAction) in
        let itm = alertController.textFields?[0]
            self?.itemName = itm?.text
        let qty = alertController.textFields?[1]
        
        if ((itm?.text?.trimmingCharacters( in: CharacterSet.whitespacesAndNewlines).characters.count)! != 0 && (qty?.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count)! != 0 )
        {
            self?.itemArray.append((itm?.text)!)
            self?.qtyArray.append((qty?.text!)!)
            
            self?.tableview.reloadData()
            self?.cfrm.isEnabled = true
        }
        else
        {
            self!.present(alertController, animated: true, completion: nil)
            self?.cfrm.isEnabled = false
        }
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
    
        self.present(alertController, animated: true, completion: nil)
        self.tableview.reloadData()
     }
   
    @IBOutlet var tableview: UITableView!
    @IBAction func confirm(_ sender: AnyObject)
    {
        if vnonveg.selectedSegmentIndex == 0
        {
            self.VNon = "VEG"
        }
        else if vnonveg.selectedSegmentIndex == 1
        {
            self.VNon = "NON-VEG"
        }
        let date = Date()
        let calendar = Calendar.current
        var componentsh = (calendar as NSCalendar).components([.hour], from: date)
        var componentsm = (calendar as NSCalendar).components([.minute], from: date)
        let chour = componentsh.hour!
        let cmin = componentsm.minute!

        self.appref = ref.child("AppData")
        self.userRef = self.appref.child(self.passphone.text!)
        self.foodRef = self.userRef.child("FoodDetails")
        self.itemRef = self.foodRef.child("ITEMS")
        self.qtyRef = self.foodRef.child("QUANTITY")
        
        let fooddata = ["Serves":self.serves.text!,"ExpiryTimeH":self.hours.text!,"ExpiryTimeM":self.mins.text!,"VegNonveg":self.VNon!, "ItemCount":self.itemArray.count,"Claim":0] as [String:Any]
        foodRef.setValue(fooddata)
        itemRef.setValue(itemArray)
        qtyRef.setValue(qtyArray)

        if ((serves.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count)! != 0 && (hours.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count)! != 0 && (mins.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count)! != 0) && itemArray.count != 0 && qtyArray.count != 0
        {
            let a = UIAlertController(title: "FOODEEDS!", message: "\nTHANK YOU FOR THE DONATION.\n\n* Foodeeds is not responsible for collection or delivery of food.", preferredStyle: .alert)
            
            let b = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) -> Void in
                
               
                self.tabBarController?.selectedIndex = 2
                 let viewcontrollers = self.tabBarController?.viewControllers
                let nav = viewcontrollers?[2] as? UINavigationController
                let thirdview = nav?.viewControllers[0] as? ThirdViewController
                thirdview?.pno = "ddd"
                self.navigationController?.popToRootViewController(animated: true)
        }
            a.addAction(b)
            self.present(a, animated: true, completion: nil)
        }
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
