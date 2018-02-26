//
//  FirstViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/23/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
import Firebase

class FirstViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate, UITextFieldDelegate
{
     let locationManager = CLLocationManager()
    
    @IBOutlet weak var totalbgk: UILabel!
    
    @IBOutlet weak var doorLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    var locValue:CLLocationCoordinate2D!
    var ref:FIRDatabaseReference!
    var userRef:FIRDatabaseReference!
    var userDataRef:FIRDatabaseReference!
    var dAddRef:FIRDatabaseReference!
    var appref:FIRDatabaseReference!
    var cdaclick:Int = 0
    var flag:Int = 0
   
    override  func viewDidLoad()
    {
        self.detect.isHidden = true
        self.change.isHidden = true
        self.detect.isEnabled = false
        self.change.isEnabled = false
        
        self.totalbgk.isHidden = false
        super.viewDidLoad()
        
        let userdefaults = UserDefaults.standard
   
        self.uname.text = userdefaults.value(forKey: "Username") as! String?
        self.phoneno.text = userdefaults.value(forKey: "Phone") as! String?
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.prefersStatusBarHidden

        ref = FIRDatabase.database().reference()
        appref = self.ref.child("AppData")
        self.userRef = self.appref.child(self.phoneno.text!)
        self.dAddRef = self.userRef.child("DefaultAddress")
        dAddRef.observe(.value, with: { (snapshot) in
            let data = snapshot.value as? [String:Any]
            if data != nil
            {
                for (key,value) in data!
                {
                    self.doorLabel.text = data?["Door"] as! String
                    self.streetLabel.text = data?["Street"] as! String
                    self.localityLabel.text = data?["Locality"] as! String
                    self.cityLabel.text = data?["City"] as! String
                    self.pincodeLabel.text = data?["State"] as! String
                }
            }
        })
        
        let alertcontroller = UIAlertController(title: "FOODEEDS", message: "\nDo you want to?", preferredStyle: .alert)
        
        let donatebutton = UIAlertAction(title: "Donate", style: .default) { (UIAlertAction) -> Void in
            self.totalbgk.isHidden = true
        }
        
        let claimbutton = UIAlertAction(title: "Claim", style: .default) { (UIAlertAction) -> Void in
            self.totalbgk.isHidden = true
            self.tabBarController?.selectedIndex = 1
        }

        alertcontroller.addAction(donatebutton)
        alertcontroller.addAction(claimbutton)
        self.present(alertcontroller, animated: true, completion: nil)

        a1.delegate = self
        a2.delegate = self
        a3.delegate = self
        a4.delegate = self
        a5.delegate = self
        
        
        if xyz.isOn == true
        {
            self.detect.isEnabled = false
            self.change.isEnabled = false
        }
    }
    
    @IBOutlet weak var bg1: UILabel!
    @IBOutlet weak var bg2: UILabel!
    @IBOutlet weak var uname: UILabel!
    @IBOutlet weak var a1: UITextField!
    @IBOutlet weak var a2: UITextField!
    @IBOutlet weak var a3: UITextField!
    @IBOutlet weak var a4: UITextField!
    @IBOutlet weak var a5: UITextField!
    @IBOutlet weak var dal: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet var xyz: UISwitch!
    @IBOutlet var detect: UIButton!
    @IBOutlet var change: UIButton!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.locValue = (manager.location?.coordinate)!
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            var placemark:CLPlacemark!
            placemark = placemarks?[0]
            
            if let locationname = placemark.addressDictionary!["SubThoroughfare"] as? NSString
            {
                self.a1.text = locationname as String
            }
            
            if let locationname = placemark.addressDictionary!["Thoroughfare"] as? NSString
            {
                self.a2.text = locationname as String
            }

            if let locationname = placemark.addressDictionary!["SubLocality"] as? NSString
            {
                self.a3.text = locationname as String
            }

            if let locationname = placemark.addressDictionary!["City"] as? NSString
            {
                self.a4.text = locationname as String
            }

            if let locationname = placemark.addressDictionary!["State"] as? NSString
            {
                self.a5.text = locationname as String
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func detectloc(_ sender: UIButton)
    {
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBOutlet var phoneno: UILabel!
    
    var user = ""
    var phone = ""
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        dal.text = ""
        bg1.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        bg2.backgroundColor=UIColor.white
        xyz.isOn = false
        xyz.tintColor = UIColor.white
        self.detect.isEnabled = true
        self.change.isEnabled = true
        self.detect.isHidden = false
        self.change.isHidden = false
    }
    
    @IBAction func sda(_ sender: UISwitch)
    {
        if sender.isOn
        {
            self.detect.isEnabled = false
            self.change.isEnabled = false
            dal.text = "(Use Default Address)"
            bg2.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
            bg1.backgroundColor=UIColor.white
            self.a1.placeholder = ""
            self.a2.placeholder = ""
            self.a3.placeholder = ""
            self.a4.placeholder = ""
            self.a5.placeholder = ""
            self.detect.isHidden = true
            self.change.isHidden = true
            
        }
        else
        {
            self.detect.isHidden = false
            self.change.isHidden = false
            xyz.tintColor = UIColor.white

            dal.text = ""
            bg1.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)

            bg2.backgroundColor=UIColor.white
            self.detect.isEnabled = true
            self.change.isEnabled = true
        }
    }
    
    @IBAction func cda(_ sender: UIButton)
    {
        if a1.text == ""
        {
            a1.placeholder = "Mandatory field."
        }
        if a2.text == ""
        {
            a2.placeholder = "Mandatory field."
        }
        if a3.text == ""
        {
            a3.placeholder = "Mandatory field."
        }
        if a4.text == ""
        {
            a4.placeholder = "Mandatory field."
        }
        if a5.text == ""
        {
            a5.placeholder = "Mandatory field."
        }
        
        if a1.text != "" && a2.text != "" && a3.text != "" && a4.text != "" && a5.text != ""
        {
            let a = UIAlertController(title: uname.text, message: a1.text! + "\n" + a2.text! + "\n" + a3.text! + "\n" + a4.text!  + "\n" + a5.text! , preferredStyle: .alert)
            let b = UIAlertAction(title: "Confirm", style: .default) { (UIAlertAction) -> Void in
            
                self.cdaclick = 1
                self.doorLabel.text = self.a1.text!
                self.streetLabel.text = self.a2.text!
                self.localityLabel.text = self.a3.text!
                self.cityLabel.text = self.a4.text!
                self.pincodeLabel.text = self.a5.text!

                self.a1.text = ""
                self.a2.text = ""
                self.a3.text = ""
                self.a4.text = ""
                self.a5.text = ""
                
                self.xyz.isOn = true
                self.detect.isHidden = true
                self.change.isHidden = true
                
                self.dal.text = "(Use Default Address)"
                self.bg2.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
                self.bg1.backgroundColor=UIColor.white
                
                self.a1.placeholder = ""
                self.a2.placeholder = ""
                self.a3.placeholder = ""
                self.a4.placeholder = ""
                self.a5.placeholder = ""
            
                self.detect.isEnabled = false
                self.change.isEnabled = false
                
        }
            let c = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) -> Void in
                self.detect.isHidden = false
                self.change.isHidden = false
           }
            a.addAction(b)
            a.addAction(c)
            self.present(a, animated: true, completion: nil)
        }
    }
  
    @IBAction func next(_ sender: UIButton)
    {
        FIRAuth.auth()?.createUser(withEmail: "a@a.com",password: "123456", completion: { (user, error) in
            
        })
        FIRAuth.auth()?.signIn(withEmail: "a@a.com", password: "123456", completion: { (user, error) in
            
            //print(user?.uid)//check for this value when user logs in and decide where to take him i.e signup or user details
            
        })
        
         if xyz.isOn && self.doorLabel.text != "" && self.streetLabel.text != "" && self.localityLabel.text != "" && self.cityLabel.text != "" && self.pincodeLabel.text != ""
         {
            self.ref = FIRDatabase.database().reference()
            self.appref = ref.child("AppData")
            self.userRef = self.appref.child(self.phoneno.text!)
            let addressdata = ["AddressBit":"D"]
            userRef.setValue(addressdata)
            self.userDataRef = self.userRef.child("UserDetails")
            let userData = ["Username":self.uname.text!]
            self.userDataRef.setValue(userData)
            let addRef = self.userRef.child("DefaultAddress")
            let userdata = ["Door":self.doorLabel.text!,"Street":self.streetLabel.text!,"Locality":self.localityLabel.text!,"City":self.cityLabel.text!,"State":self.pincodeLabel.text!] as [String:Any]
            addRef.setValue(userdata)
            
        }
        else if xyz.isOn == false && self.a1.text != "" && self.a2.text != "" && self.a3.text != "" && self.a4.text != "" && self.a5.text != ""
         {
            if self.cdaclick == 1
            {
                self.ref = FIRDatabase.database().reference()
                self.appref = ref.child("AppData")
                self.userRef = self.appref.child(self.phoneno.text!)
                let addressData = ["AddressBit":"D"]
                userRef.setValue(addressData)
                self.userDataRef = self.userRef.child("UserDetails")
                let userData = ["Username":self.uname.text!]
                self.userDataRef.setValue(userData)
                let addRef1 = self.userRef.child("DefaultAddress")
                let userdata1 = ["Door":self.doorLabel.text!,"Street":self.streetLabel.text!,"Locality":self.localityLabel.text!,"City":self.cityLabel.text!,"State":self.pincodeLabel.text!] as [String:Any]
                addRef1.setValue(userdata1)
            }
            else
            {
                self.ref = FIRDatabase.database().reference()
                self.appref = ref.child("AppData")
                self.userRef = appref.child(self.phoneno.text!)
                let addressData = ["AddressBit":"T"]
                userRef.setValue(addressData)
                self.userDataRef = self.userRef.child("UserDetails")
                let userData = ["Username":self.uname.text!]
                self.userDataRef.setValue(userData)
                let addRef = userRef.child("DefaultAddress")
                let userdata = ["Door":self.doorLabel.text!,"Street":self.streetLabel.text!,"Locality":self.localityLabel.text!,"City":self.cityLabel.text!,"State":self.pincodeLabel.text!] as [String:Any]
                addRef.setValue(userdata)
                let addRef1 = self.userRef.child("TextFieldAddress")
                let userdata1 = ["Door":self.a1.text!,"Street":self.a2.text!,"Locality":self.a3.text!,"City":self.a4.text!,"State":self.a5.text!] as [String:Any]
                addRef1.setValue(userdata1)
            }
        }
        
         else if xyz.isOn && self.doorLabel.text == "" && self.streetLabel.text == "" && self.localityLabel.text == "" && self.cityLabel.text == "" && self.pincodeLabel.text == "" && self.a1.text != "" && self.a2.text != "" && self.a3.text != "" && self.a4.text != "" && self.a5.text != ""
         {
            self.ref = FIRDatabase.database().reference()
            self.appref = ref.child("AppData")
            self.userRef = appref.child(self.phoneno.text!)
            let addressData = ["AddressBit":"T"]
            userRef.setValue(addressData)
            self.userDataRef = self.userRef.child("UserDetails")
            let userData = ["Username":self.uname.text!]
            self.userDataRef.setValue(userData)
            let addRef1 = self.userRef.child("TextFieldAddress")
            let userdata1 = ["Door":self.a1.text!,"Street":self.a2.text!,"Locality":self.a3.text!,"City":self.a4.text!,"State":self.a5.text!] as [String:Any]
            addRef1.setValue(userdata1)
        }
        
        else if xyz.isOn == false && self.a1.text == "" && self.a2.text == "" && self.a3.text == "" && self.a4.text == "" && self.a5.text == "" && self.doorLabel.text != "" && self.streetLabel.text != "" && self.localityLabel.text != "" && self.cityLabel.text != "" && self.pincodeLabel.text != ""
         {
            self.ref = FIRDatabase.database().reference()
            self.appref = ref.child("AppData")
            self.userRef = self.appref.child(self.phoneno.text!)
            let addressdata = ["AddressBit":"D"]
            userRef.setValue(addressdata)
            self.userDataRef = self.userRef.child("UserDetails")
            let userData = ["Username":self.uname.text!]
            self.userDataRef.setValue(userData)
            let addRef = self.userRef.child("DefaultAddress")
            let userdata = ["Door":self.doorLabel.text!,"Street":self.streetLabel.text!,"Locality":self.localityLabel.text!,"City":self.cityLabel.text!,"State":self.pincodeLabel.text!] as [String:Any]
            addRef.setValue(userdata)
        }
        performSegue(withIdentifier: "dtod1", sender: self)
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
