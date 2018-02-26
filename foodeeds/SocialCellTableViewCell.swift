//
//  SocialCellTableViewCell.swift
//  foodeeds
//
//  Created by iOSbatch1 on 1/31/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit

class SocialCellTableViewCell: UITableViewCell
{

    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet var labels: UILabel!
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
