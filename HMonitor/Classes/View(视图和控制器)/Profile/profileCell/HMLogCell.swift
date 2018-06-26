//
//  HMLogCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMLogCell: UITableViewCell {
    @IBOutlet weak var timeImg: UIImageView!
    @IBOutlet weak var pkImg: UIImageView!
    @IBOutlet weak var qyImg: UIImageView!
    @IBOutlet weak var dxTimeLab: UILabel!
    @IBOutlet weak var pkLab: UILabel!
    @IBOutlet weak var qyLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
