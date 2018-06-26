//
//  HMQyDetailCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMQyDetailCell: UITableViewCell {

    @IBOutlet weak var pkNameLab: UILabel!
    
    @IBOutlet weak var stateLab: UILabel!
    @IBOutlet weak var deviceNameLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
