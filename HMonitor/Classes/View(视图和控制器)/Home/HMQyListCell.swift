//
//  HMQyListCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMQyListCell: UITableViewCell {
    @IBOutlet weak var qyNameLab: UILabel!
    @IBOutlet weak var pkCountLab: UILabel!
    @IBOutlet weak var sbLab: UILabel!
    @IBOutlet weak var currentLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
