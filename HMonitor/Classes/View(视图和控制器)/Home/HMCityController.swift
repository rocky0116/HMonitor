//
//  HMCityController.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMCityController: WBBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var areas : [AreaModel] = []
    
    
    let tableview = UITableView()
    
    override func setupUI() {
        super.setupUI()
        
        navigationItem.title = "区域列表"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 14, target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: aCity!, target: self, action: #selector(defaultCity))
        
        addTable()
        loadCity()
       
    }
    
    @objc func defaultCity(){
        self.close()
    }
    
    func loadCity(){
        WZNetworkTool.shareNetworkTool.loadArea(userAccnum: userAccnum!, token: ten!, areaCode: aCode!) { (cityInfo) in
            self.areas = cityInfo.data.xianArea!.map({ (xian) -> AreaModel in
                return AreaModel(areaName: xian.areaName, areaCode: xian.areaCode)
            })
            self.tableview.reloadData()
        }
    }
    
    //MARK: 添加表格视图
    func addTable(){
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.top.equalTo(navigationBar.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
            make.bottom.equalToSuperview()
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorInset = UIEdgeInsets.zero
        tableview.layoutMargins = UIEdgeInsets.zero
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        refresh()
    }
    
    
    //MARK: 表格刷新
    func refresh(){
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        
        footer.isHidden = true
        
        self.tableview.mj_header = header
        
    }
    
    @objc func headerRefresh(){
        self.tableview.mj_header.endRefreshing()//结束头部刷新
        loadCity()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = areas[indexPath.row].areaName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userDefault = UserDefaults.standard
        userDefault.set(areas[indexPath.row].areaCode!, forKey: areaCode)
        userDefault.synchronize()
        print(areas[indexPath.row].areaCode!)
        self.close()
    }
    
    //MARK: 关闭控制器
    @objc private func close (){
        dismiss(animated: true, completion: nil)
    }
    
}
