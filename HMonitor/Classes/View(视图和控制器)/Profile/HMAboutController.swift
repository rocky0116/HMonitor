//
//  HMAboutController.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMAboutController: WBBaseViewController {

    lazy var headView = UIView()
    lazy var img1 = UIImageView(image: UIImage(named: "idea_add"))
    lazy var img2 = UIImageView(image: UIImage(named: "idea_no"))
    lazy var img3 = UIImageView(image: UIImage(named: "idea_no"))
   
   
    override func setupUI() {
        super.setupUI()
        title = "关于我们"
        addUI()
    }
    
   
    
    func addUI(){
        headView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 360)
        
        
        headView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight - 100)
            make.top.equalTo(navigationBar.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
       
    }
    
   
}
