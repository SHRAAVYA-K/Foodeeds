//
//  CustomTableViewCell.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/30/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{
    @IBOutlet weak var item: UITextField!
    @IBOutlet weak var quantity: UITextField!
    
    
 
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
