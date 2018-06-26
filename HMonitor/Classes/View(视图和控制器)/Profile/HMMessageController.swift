//
//  HMMessageController.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMMessageController: WBBaseViewController,UITableViewDataSource,UITableViewDelegate {
    lazy var tableView = UITableView()
    let qyNames = ["[国]忻州广宇煤电有限公司","[国]忻州广宇煤电有限公司","[国]忻州广宇煤电有限公司","[国]忻州广宇煤电有限公司"]
    let cbDatas = ["连续8小时存在超标","连续8小时存在超标","连续8小时存在超标","连续8小时存在超标"]
    let dates = ["2018-05-09 13:09:55","2018-05-09 13:09:55","2018-05-09 13:09:55","2018-05-09 13:09:55"]
    override func setupUI() {
        super.setupUI()
        title = "预警消息"
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight)
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        
        tableView.register(UINib(nibName: "HMMessageCell", bundle: nil), forCellReuseIdentifier: "CellID")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? HMMessageCell
        
        cell?.qyNameLab.text = qyNames[indexPath.row]
        cell?.cbDataLab.text = cbDatas[indexPath.row]
        cell?.dateLab.text = dates[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
