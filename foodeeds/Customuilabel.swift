//
//  Customuilabel.swift
//  foodeeds
//
//  Created by iOSbatch1 on 3/8/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//

import UIKit

class Customuilabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        self.font = UIFont(name: "Helvetica Neue", size: 16)
        self.textColor = UIColor(red: 39/255, green: 62/255, blue: 97/255, alpha: 1.0)
    }

}
