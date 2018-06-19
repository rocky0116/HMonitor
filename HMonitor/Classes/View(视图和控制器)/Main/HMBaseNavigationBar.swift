//
//  HMBaseNavigationBar.swift
//  HMonitor
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMBaseNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            print("--------- \(stringFromClass)")
            if stringFromClass.contains("BarBackground") {
                subview.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0, y: 20, width: UIScreen.cz_screenWidth(), height: 44)
            }
        }
    }

}
