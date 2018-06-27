//
//  HMAboutController.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMAboutController: WBBaseViewController {

    lazy var lab = UILabel()
    lazy var img1 = UIImageView(image: UIImage(named: "about1"))
    lazy var img2 = UIImageView(image: UIImage(named: "about2"))
    lazy var img3 = UIImageView(image: UIImage(named: "about3"))
   
   
    override func setupUI() {
        super.setupUI()
        title = "关于我们"
        self.view.backgroundColor = UIColor.cz_color(withRed: 213, green: 233, blue: 247)
        addUI()
    }
    
   
    
    func addUI(){
       
        self.view.addSubview(img1)
        
        img1.snp.makeConstraints { (make) in
            make.width.equalTo(180)
            make.height.equalTo(70)
            make.top.equalTo(navigationBar.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(lab)
        lab.text = "V3.0"
        lab.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.top.equalTo(img1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(img2)
        img2.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(lab.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(img3)
        img3.snp.makeConstraints { (make) in
            make.height.equalTo(160)
            make.bottom.equalToSuperview().offset(0)
            make.width.equalTo(screenWidth)
        }
       
    }
    
   
}
