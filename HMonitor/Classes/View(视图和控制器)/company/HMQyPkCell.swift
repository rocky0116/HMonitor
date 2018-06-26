//
//  HMQyPkCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMQyPkCell: UITableViewCell {
    @IBOutlet weak var dayLab: UILabel!
    @IBOutlet weak var hourLab: UILabel!
    @IBOutlet weak var currentLab: UILabel!
    @IBOutlet weak var yzLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
