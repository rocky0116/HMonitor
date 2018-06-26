//
//  HMDataView.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMDataView: UIView {

    class func xDataView() -> HMDataView {
        let nib = UINib(nibName: "HMDataView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! HMDataView
        //从xib 加载的视图，默认是 600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }

}
