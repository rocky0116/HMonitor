//
//  HMQyDetailController.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMQyDetailController: WBBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    lazy var qyNameLab = UILabel()
    lazy var addressLab = UILabel()
    lazy var qyInfoLab = UILabel()
    
    lazy var view1 = UIView()
    lazy var lab1 = UILabel()
    lazy var lab2 = UILabel()
    lazy var lab3 = UILabel()
    
    lazy var tableView = UITableView()
    var qyId : String?
    var qyPhone : String?
    var qyDatas : [QyDetailCompanyData] = []
    
    override func setupUI() {
        super.setupUI()
        title = "企业详情"
        
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "电话"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(goCall))
        
        addUI()
        loadQyDetail()

    }
    
    func addUI() -> () {
        self.view.addSubview(qyNameLab)
        qyNameLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
        }
        qyNameLab.textColor = UIColor.darkGray
        qyNameLab.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(addressLab)
        addressLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
            make.top.equalTo(qyNameLab.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
        }
        addressLab.textColor = UIColor.darkGray
        addressLab.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(qyInfoLab)
        qyInfoLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
            make.top.equalTo(addressLab.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
        }
        qyInfoLab.textColor = UIColor.darkGray
        qyInfoLab.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(view1)
        view1.backgroundColor = UIColor.cz_color(withHex: 0xEFEFF4)
        view1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(40)
            make.top.equalTo(qyInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab1)
        lab1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/3)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(qyInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab2)
        lab2.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/3)
            make.height.equalTo(40)
            make.left.equalTo(lab1.snp.right).offset(0)
            make.top.equalTo(qyInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab3)
        lab3.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/3)
            make.height.equalTo(40)
            make.left.equalTo(lab2.snp.right).offset(0)
            make.top.equalTo(qyInfoLab.snp.bottom).offset(15)
        }
        
        lab1.textAlignment = .center
        lab2.textAlignment = .center
        lab3.textAlignment = .center
        lab1.text = "排口名称"
        lab2.text = "设备名称"
        lab3.text = "排口状态"
        lab1.font = UIFont.systemFont(ofSize: 14)
        lab2.font = UIFont.systemFont(ofSize: 14)
        lab3.font = UIFont.systemFont(ofSize: 14)
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(300)
            make.top.equalTo(view1.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "HMQyDetailCell", bundle: nil), forCellReuseIdentifier: "CellID")
    }
    
    func loadQyDetail() -> () {
        WZNetworkTool.shareNetworkTool.loadQyDetail(userAccnum: userAccnum!, token: ten!, companyId: self.qyId!) { (objInfo) in
            self.qyNameLab.text = objInfo.data.companyName
            self.addressLab.text = objInfo.data.companyAddress
            self.qyInfoLab.text = "排口情况：废气排口\(objInfo.data.pqNum!),废水排口\(objInfo.data.psNum!)"
            self.qyDatas = objInfo.data.companyData!
            self.qyPhone = objInfo.data.envPhone!
            self.tableView.reloadData()
        }
    }
    
    @objc func goCall(){
        if self.qyPhone! == "" {
            //自动打开拨号页面并自动拨打电话
            let alert = UIAlertView(title: "温馨提示", message: "没有电话号码", delegate: nil, cancelButtonTitle: "知道了")
            alert.show()
        }else{
            
            let urlString = "tel://\(self.qyPhone!)"
            if let url = URL(string: urlString) {
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! HMQyDetailCell
        
        cell.pkNameLab.text = qyDatas[indexPath.row].outletName!
        var sbDbvice = ""
        var sbDischarge = ""
        if qyDatas[indexPath.row].isEquipmentDx {
            sbDbvice = "掉线"
        }else if qyDatas[indexPath.row].isEquipmentYc {
            sbDbvice = "异常"
        }else{
            sbDbvice = "正常"
        }
        
        if qyDatas[indexPath.row].isOutletDx {
            sbDischarge = "掉线"
        }else if qyDatas[indexPath.row].isOutletCp {
            sbDischarge = "超标"
        }else if qyDatas[indexPath.row].isOutletYc {
            sbDischarge = "异常"
        }else{
            sbDischarge = "正常"
        }
        
        cell.deviceNameLab.text = sbDbvice
        cell.stateLab.text = sbDischarge
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        let vc = HMQyPkDetailController()
        vc.qyId = self.qyId!
        vc.pkId = qyDatas[indexPath.row].outletId!
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
