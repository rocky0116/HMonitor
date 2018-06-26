//
//  HMFeedBackCell.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMFeedBackCell: UITableViewCell {

    
    ///视图模型
    var viewModel: IdeaData? {
        didSet {
            //时间戳
            let timeStamp = (viewModel?.createDate)!/1000
            //转换为时间
            let timeInterval:TimeInterval = TimeInterval(timeStamp)
            let date = Date(timeIntervalSince1970: timeInterval)
            
            //格式话输出
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            print("对应的日期时间：\(dformatter.string(from: date))")
            // 设置来源
            contentLab.text = viewModel?.content
            // 姓名
            contactLab.text = viewModel?.contact
            // 设置时间
            timeLab.text = dformatter.string(from: date)
            // 配图视图视图模型
            pictureView.viewModel = viewModel
        }
    }
   
    @IBOutlet weak var pictureView: HMPictureView!
    
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var contactLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        // cell 优化，要尽量减少图层的数量，相当于就只有一层！
        // 停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        // 使用 `栅格化` 必须注意指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
