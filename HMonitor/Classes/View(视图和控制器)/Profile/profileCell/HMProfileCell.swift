//
//  HMProfileCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMProfileCell: UITableViewCell {

    @IBOutlet weak var pImg: UIImageView!
    
    @IBOutlet weak var pNameLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
