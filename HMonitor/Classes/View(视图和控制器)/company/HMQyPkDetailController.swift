//
//  HMQyPkDetailController.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMQyPkDetailController: WBBaseViewController,UITableViewDataSource,UITableViewDelegate {
    var pkDatas : [PkDetailOutletData] = []
   
    var qyId : String?
    var pkId : String?
    var yzType : String?
    
    lazy var tableView = UITableView()
    lazy var pkInfoLab = UILabel()
    lazy var qyNameLab = UILabel()
    
    lazy var view1 = UIView()
    lazy var lab1 = UILabel()
    lazy var lab2 = UILabel()
    lazy var lab3 = UILabel()
    lazy var lab4 = UILabel()
    override func setupUI() {
        super.setupUI()
        title = "排口详情"
        addUI()
        loadQyDetail()
        
    }
    
    func addUI() -> () {
        self.view.addSubview(qyNameLab)
        qyNameLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
            make.top.equalTo(navigationBar.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
        }
        self.view.addSubview(pkInfoLab)
        pkInfoLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
            make.top.equalTo(qyNameLab.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
        }
        
        self.view.addSubview(view1)
        view1.backgroundColor = UIColor.cz_color(withHex: 0xEFEFF4)
        view1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(40)
            make.top.equalTo(pkInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab1)
        lab1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/4)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(pkInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab2)
        lab2.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/4)
            make.height.equalTo(40)
            make.left.equalTo(lab1.snp.right).offset(0)
            make.top.equalTo(pkInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab3)
        lab3.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/4)
            make.height.equalTo(40)
            make.left.equalTo(lab2.snp.right).offset(0)
            make.top.equalTo(pkInfoLab.snp.bottom).offset(15)
        }
        self.view1.addSubview(lab4)
        lab4.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/4)
            make.height.equalTo(40)
            make.left.equalTo(lab3.snp.right).offset(0)
            make.top.equalTo(pkInfoLab.snp.bottom).offset(15)
        }
        
        lab1.textAlignment = .center
        lab2.textAlignment = .center
        lab3.textAlignment = .center
        lab4.textAlignment = .center
        lab1.text = "监测因子"
        lab2.text = "实时数据"
        lab3.text = "小时数据"
        lab4.text = "日数据"
        lab1.font = UIFont.systemFont(ofSize: 14)
        lab2.font = UIFont.systemFont(ofSize: 14)
        lab3.font = UIFont.systemFont(ofSize: 14)
        lab4.font = UIFont.systemFont(ofSize: 14)
        
        
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
        tableView.register(UINib(nibName: "HMQyPkCell", bundle: nil), forCellReuseIdentifier: "CellID")
    }
    
    func loadQyDetail() -> () {
        WZNetworkTool.shareNetworkTool.loadPkDetail(userAccnum: userAccnum!, token: ten!, companyId: qyId!, outletId: pkId!) { (objInfo) in
            self.pkDatas = objInfo.data.outletData!
            
            self.yzType = objInfo.data.outletType!
            self.qyNameLab.text = objInfo.data.companyName!
            var sbSta : String?
            if objInfo.data.isEquipmentDx {
                sbSta = "掉线"
            } else if objInfo.data.isEquipmentYc {
                sbSta = "异常"
            }else{
                sbSta = "正常"
            }
            self.pkInfoLab.text = "设备状态：" + sbSta!
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pkDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! HMQyPkCell
        
        cell.yzLab.text = pkDatas[indexPath.row].monitorName!
        cell.currentLab.text = pkDatas[indexPath.row].realtime!
        
        cell.hourLab.text = pkDatas[indexPath.row].hourData!
        cell.dayLab.text = pkDatas[indexPath.row].dayData!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = HMQyYZDetailController()
        vc.qyId = self.qyId!
        vc.pkId = self.pkId!
        vc.yzType = self.yzType!
        vc.yzId = pkDatas[indexPath.row].monitorId!
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
