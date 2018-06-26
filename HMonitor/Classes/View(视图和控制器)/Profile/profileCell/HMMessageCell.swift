//
//  HMMessageCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMMessageCell: UITableViewCell {
    @IBOutlet weak var dateLab: UILabel!
    @IBOutlet weak var cbDataLab: UILabel!
    @IBOutlet weak var qyNameLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
