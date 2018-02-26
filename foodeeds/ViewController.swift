//
//  ViewController.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/23/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController //UITableViewDataSource, UITableViewDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

