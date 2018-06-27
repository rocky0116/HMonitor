//
//  HMQyListController.swift
//  HMonitor
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMQyListController: WBBaseViewController,UITableViewDelegate,UITableViewDataSource {

    let tableview = UITableView()
    var popMenu:SwiftPopMenu!
    
    var pkType = "1"
    var qyDatas : [HomeQyQyList] = []
    var qyInfoDatas : [HomeQyInfoCompanyData] = []
    
    var qyId : String?
    override func setupUI() {
        super.setupUI()
        setupNavTitle()
        addSegmented()
        addTable()
        getQyList()
    }
    
    
    @objc func showType() {
        popMenu = SwiftPopMenu(frame:  CGRect(x: screenWidth-160, y: 70, width: 150, height: 250), arrowMargin: 12)
        
        popMenu.popData = [(icon:"电话",title:"所有企业"),
                           (icon:"电话",title:"正常企业"),
                           (icon:"电话",title:"超标企业"),
                           (icon:"电话",title:"异常企业"),
                           (icon:"电话",title:"掉线企业")]
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            //            print("block select \(index)")
        }
        popMenu.show()
    }
    
    override func segementDidchange(segmented: UISegmentedControl) {
        pkType = "\(segmented.selectedSegmentIndex+1)"
        getQyList()
    }
    
    //MARK: 企业列表-用于在地图上显示坐标
    func getQyList(){
        WZNetworkTool.shareNetworkTool.loadHomeQy(userAccnum: userAccnum!, token: ten!, acode: aCode!, pkType: pkType) { (objInfo) in
            self.qyDatas = objInfo.data.qyList!
            self.tableview.reloadData()
        }
    }
    
    //MARK: 添加表格视图
    func addTable(){
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.top.equalTo(segmented.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(0)
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorInset = UIEdgeInsets.zero
        tableview.layoutMargins = UIEdgeInsets.zero
        tableview.register(UINib(nibName: "HMQyListCell", bundle: nil), forCellReuseIdentifier: "CellID")
        
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
        getQyList()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! HMQyListCell
        
        cell.qyNameLab.text = qyDatas[indexPath.row].qyName
        cell.pkCountLab.text = "共有排口：1"
        
        if !qyDatas[indexPath.row].ycType && !qyDatas[indexPath.row].cpType && !qyDatas[indexPath.row].dxType{
            cell.sbLab.text = "设备状态：正常"
            cell.currentLab.text = "实时数据：正常"
        }else if qyDatas[indexPath.row].ycType{
            cell.sbLab.text = "设备状态：正常"
            cell.currentLab.text = "实时数据：异常"
        }else if qyDatas[indexPath.row].cpType{
            cell.sbLab.text = "设备状态：正常"
            cell.currentLab.text = "实时数据：超标"
        }else{
            cell.sbLab.text = "设备状态：掉线"
            cell.currentLab.text = "实时数据：掉线"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = HMQyDetailController()
        vc.qyId = qyDatas[indexPath.row].qyId!
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

// MARK: - 设置界面
extension HMQyListController {
    
    /// 设置导航栏标题
    func setupNavTitle() {
        
        title = "企业列表"
        
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "分类"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(showType))
    }
 
}
