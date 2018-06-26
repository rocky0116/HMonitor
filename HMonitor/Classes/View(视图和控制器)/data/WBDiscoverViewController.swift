//
//  WBDiscoverViewController.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit


class WBDiscoverViewController: WBBaseViewController,DOPDropDownMenuDataSource, DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource,JTSegmentControlDelegate {

    
    let allQySorts: [String] = ["所有企业","异常企业","超标企业","掉线企业"]
    let jczSorts = ["监测值", "默认排序", "由低到高", "由高到低"]
    let cbbsSorts = ["超标倍数", "默认排序", "由低到高", "由高到低"]
    var dopMenu : DOPDropDownMenu = DOPDropDownMenu()
    var titles : [String] = []
    var yzIds : [String] = []
    
    var type = "1"
    var tableType = "1"
    
    var qyDatas : [QyDataDataList] = []
    
    var popMenu:SwiftPopMenu!
    var yzId : String?
    
    var testingType = "-1"
    var multipleType = "-1"
    var qyType = "0"
    var page = 1
    
    let tableview = UITableView()
    let sView = UIView()
    override func setupUI() {
        super.setupUI()
        print("数据查询")
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "时间"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(showPop))
        
        addSegmented()
        addYzUi()
        addDrop()
        addTable()
        
        
        loadYzType()
    }
    
    override func segementDidchange(segmented: UISegmentedControl) {
        type = "\(segmented.selectedSegmentIndex+1)"
        loadYzType()
    }
    
    //MARK: 添加因子视图
    func addYzUi(){
        self.view.addSubview(sView)
        sView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(44)
            make.top.equalTo(segmented.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
        
        addDrop()
        addTable()
    }
    
    //MARK: 添加筛选条件
    func addDrop(){
        //筛选框
        dopMenu = DOPDropDownMenu(origin: CGPoint(x: 0, y: 0), height: 44)
        dopMenu.dataSource = self
        dopMenu.delegate = self
        
        dopMenu.selectDefalutIndexPath()
        dopMenu.backgroundColor = UIColor.white
        self.view.addSubview(dopMenu)
        dopMenu.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(44)
            make.top.equalTo(sView.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
 
    }
    
    //MARK: 添加表格视图
    func addTable(){
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.top.equalTo(dopMenu.snp.bottom).offset(5)
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
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        
        self.tableview.mj_header = header
        self.tableview.mj_footer = footer
        
    }
    
    @objc func headerRefresh(){
        self.tableview.mj_header.endRefreshing()//结束头部刷新
        page = 1
        loadQyData()
    }
    
    @objc func footerRefresh(){
        page = page + 1
        print(page)
        self.tableview.mj_footer.endRefreshing()//结束尾部刷新
        loadQyData()
    }
    
    //MARK: 加载因子列表数据
    func loadYzType(){
        WZNetworkTool.shareNetworkTool.loadDataYzType(userAccnum: userAccnum!, token: ten!, type: type) { (objInfo) in
            self.titles.removeAll()
            self.yzIds.removeAll()
            
            print(objInfo.data.monitorData.count)
            for ss in objInfo.data.monitorData {
                self.titles.append(ss.monitorName)
                self.yzIds.append(ss.monitorId)
            }
            
            var frame = CGRect(x: 5, y: 0, width: screenWidth, height: 44)
            let autoWidthControl = JTSegmentControl(frame: frame)
            autoWidthControl.delegate = self
            autoWidthControl.items = self.titles
            autoWidthControl.selectedIndex = 0
            autoWidthControl.autoAdjustWidth = true
            autoWidthControl.bounces = true
            
            self.sView.addSubview(autoWidthControl)
            
            self.yzId = self.yzIds[0]
            self.loadQyData()

        }
    }
    
    //MARK: 加载因子企业数据
    func loadQyData() -> () {
        WZNetworkTool.shareNetworkTool.loadDataList(userAccnum: userAccnum!, token: ten!, areaCode: aCode!, tableType: tableType, pkType: type, wrwId: self.yzId!, testingType: testingType, multipleType: multipleType, qyType: qyType, pageSize: pageSize, page: "\(page)") { (objInfo) in
            self.qyDatas = objInfo.data.dataList!
            
            self.tableview.reloadData()
        }
    }
    
    
    @objc func showPop(){
        print("我的查询")
        popMenu = SwiftPopMenu(frame:  CGRect(x: screenWidth-160, y: 70, width: 150, height: 150), arrowMargin: 12)
        
        popMenu.popData = [(icon:"电话",title:"实时数据"),
                           (icon:"电话",title:"小时数据"),
                           (icon:"电话",title:"日数据")]
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            print("block select \(index)")
            self?.tableType = "\(index+1)"
            self?.loadQyData()
            
        }
        popMenu.show()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let qyNameView = UILabel(frame: CGRect(x: 10, y: 5, width: screenWidth/2, height: 30))
        qyNameView.text = qyDatas[indexPath.row].qyName
        
        qyNameView.font = UIFont.systemFont(ofSize: 13)
        cell.addSubview(qyNameView)
        
        let pkNameView = UILabel(frame: CGRect(x: 10, y: qyNameView.frame.maxY+2, width: screenWidth/2, height: 30))
        pkNameView.text = qyDatas[indexPath.row].pkName
        pkNameView.font = UIFont.systemFont(ofSize: 13)
        pkNameView.textColor = UIColor.darkGray
        cell.addSubview(pkNameView)
        
        let valueView = UILabel(frame: CGRect(x: pkNameView.frame.maxX, y: 20, width: 100, height: 30))
        valueView.text = "\(qyDatas[indexPath.row].wrw!)"
        valueView.textColor = YMGlobalTheme()
        valueView.font = UIFont.boldSystemFont(ofSize: 13)
        cell.addSubview(valueView)
        
        let cbView = UILabel(frame: CGRect(x: valueView.frame.maxX, y: 20, width: 100, height: 30))
        cbView.text = "\(qyDatas[indexPath.row].wrwcpbs!)"
        cbView.textColor = YMGlobalTheme()
        cbView.font = UIFont.boldSystemFont(ofSize: 13)
        cell.addSubview(cbView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //qyDetailCV
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = HMQyDetailController()
        vc.qyId = qyDatas[indexPath.row].qyId!
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK:- 代理
    func numberOfColumnsInMenu(dopMenu menu: DOPDropDownMenu) -> Int {
        return 3
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, numberOfRowsInColumn column: Int) -> Int {
        if column == 0 {
            return allQySorts.count
        } else if column == 1 {
            return jczSorts.count
        } else {
            return cbbsSorts.count
        }
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, titleForRowAtIndexPath indexPath: DOPIndexPath) -> String {
        if indexPath.column == 0 {
            return allQySorts[indexPath.row!]
        } else if indexPath.column == 1 {
            return jczSorts[indexPath.row!]
        } else {
            return cbbsSorts[indexPath.row!]
        }
    }
    
    //new datasource
    func menu(dopMenu menu: DOPDropDownMenu, imageNameForRowAtIndexPath indexPath: DOPIndexPath) -> String {
        
        return ""
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, imageNameForItemsInRowAtIndexPath indexPath: DOPIndexPath) -> String {
        
        return ""
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, detailTextForRowAtIndexPath indexPath: DOPIndexPath) -> String {
        return String()
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, detailTextForItemsInRowAtIndexPath indexPath: DOPIndexPath) -> String {
        return String()
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, numberOfItemsInRow row: Int, column: Int) -> Int {
        
        return 0
    }
    
    func menu(dopMenu menu: DOPDropDownMenu, titleForItemsInRowAtIndexPath indexPath: DOPIndexPath) -> String {
        
        return "没有"
    }
    
    func menu(_ menu: DOPDropDownMenu, didSelectRowAtIndexPath indexPath: DOPIndexPath) {
        if indexPath.item! > 0 {
            print("点击了第\(indexPath.column)列 - 第\(indexPath.row)行 - 第\(indexPath.item)项")
        } else {
            print("点击了第\(indexPath.column)列 - 第\(indexPath.row)行")
        }
    }
    
    func didSelected(segement: JTSegmentControl, index: Int) {
        print("current index \(index)")
        self.yzId = self.yzIds[index]
        self.loadQyData()
    }

}
