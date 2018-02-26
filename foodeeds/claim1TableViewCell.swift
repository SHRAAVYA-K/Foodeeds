//
//  claim1TableViewCell.swift
//  foodeeds
//
//  Created by iOSbatch1 on 2/2/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit

class claim1TableViewCell: UITableViewCell {
    @IBOutlet weak var Expirytime: UILabel!
    @IBOutlet weak var vnon: UILabel!
    @IBOutlet weak var ctime: UILabel!
    @IBOutlet weak var locality: UILabel!
    @IBOutlet weak var serves: UILabel!
    @IBOutlet weak var bulletin: UILabel!
    @IBOutlet weak var claimedCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
