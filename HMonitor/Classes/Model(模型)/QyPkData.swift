//
//  QyPkData.swift
//  hxlhEmep
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
class QyPkData: NSObject {
    var time: String?
    var pkInfos: [PkInfo] = []
}

class PkInfo: NSObject{
    var qyName : String?
    var pkName : String?
    var offTime : String?
}
