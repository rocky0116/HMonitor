//
//  HMLogController.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit

class HMLogController: WBBaseViewController,UITableViewDataSource,UITableViewDelegate {
    let Titems = ["超标数据","异常数据","设备掉线"]
    
    lazy var choicTimeSegemnt = UISegmentedControl(items: Titems)
    lazy var tableView = UITableView()
    
    var logDatas : [QyPkData] = []
    
    var logType = "1"
    var queryTime : String?
    var defaultTime : String?
    override func setupUI() {
        super.setupUI()
        title = "预警日志"
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        defaultTime = "\(dformatter.string(from: now))"
        queryTime = defaultTime
        
        tableView.delegate = self
        tableView.dataSource = self
        
        choicTimeSegemnt.addTarget(self, action: #selector(segmentedControlChanged), for: UIControlEvents.valueChanged)
        
        addUI()
        
        loadLog()
        refresh()
    }
    
    func addUI(){
        self.view.addSubview(choicTimeSegemnt)
        choicTimeSegemnt.snp.makeConstraints { (make) in
            make.width.equalTo(260)
            make.height.equalTo(30)
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        let dic:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.cz_color(withHex: 0x1CA3E5),NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        let dicSelect:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        
        choicTimeSegemnt.selectedSegmentIndex = 0
        choicTimeSegemnt.setTitleTextAttributes(dic as? [AnyHashable : Any], for: .normal)
        choicTimeSegemnt.setTitleTextAttributes(dicSelect as? [AnyHashable : Any], for: .selected)
        choicTimeSegemnt.tintColor = UIColor.cz_color(withHex: 0x1CA3E5)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight - 100)
            make.top.equalTo(choicTimeSegemnt.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "HMLogCell", bundle: nil), forCellReuseIdentifier: "CellID")
    }
    
    func refresh(){
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        
        self.tableView.mj_header = header
        self.tableView.mj_footer = footer
        
    }
    
    @objc func headerRefresh(){
        logDatas.removeAll()
        self.tableView.reloadData()
        queryTime = defaultTime!
        print(queryTime!)
        self.tableView.mj_header.endRefreshing()//结束头部刷新
        loadLog()
    }
    
    @objc func footerRefresh(){
        dateJisuan()
        self.tableView.mj_footer.endRefreshing()//结束尾部刷新
        loadLog()
    }
    
    @objc func segmentedControlChanged(sender:UISegmentedControl) {
        logType = "\(sender.selectedSegmentIndex+1)"
        logDatas.removeAll()
        tableView.reloadData()
        loadLog()
    }
    
    func loadLog(){
        WZNetworkTool.shareNetworkTool.loadLog(userAccnum: userAccnum!, token: ten!, acode: aCode!, logType: logType, queryTime: queryTime!) { (objInfo) in
            for log in objInfo.data {
                var item = QyPkData()
                item.time = log.time!
                for qy in log.qyData {
                    for pk in qy.pkData{
                        var pkInfo = PkInfo()
                        pkInfo.qyName = qy.qyName!
                        pkInfo.pkName = pk.pfkName!
                        
                        var offT = ""
                        for off in pk.offTime{
                            offT += off
                        }
                        pkInfo.offTime = offT
                        
                        item.pkInfos.append(pkInfo)
                    }
                }
                self.logDatas.append(item)
            }
            self.tableView.reloadData()
        }
    }
    
    func dateJisuan(){
        
        let strTime = "\(queryTime!) 00:00:00"
        let datefmatter = DateFormatter()
        datefmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = datefmatter.date(from: strTime)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970 - 86400
        
        //转换为时间
        let cdate = Date(timeIntervalSince1970: dateStamp)
        
        //格式话输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        print("对应的日期时间：\(dformatter.string(from: cdate))")
        
        queryTime = dformatter.string(from: cdate)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return logDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logDatas[section].pkInfos.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let tview = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        
        let leftImg = UIImageView(image: UIImage(named: "log_day"))
        leftImg.frame = CGRect(x: 16, y: 8, width: 25, height: 25)
        
        let dateLab = UILabel(frame: CGRect(x: leftImg.frame.maxX+4, y: 5, width: screenWidth-50, height: 30))
        dateLab.text = logDatas[section].time!
        dateLab.font = UIFont.boldSystemFont(ofSize: 18)
        dateLab.textColor = YMGlobalTheme()
        
        
        tview.addSubview(leftImg)
        tview.addSubview(dateLab)
        
        return tview
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? HMLogCell
        
        
        cell?.qyLab.text = logDatas[indexPath.section].pkInfos[indexPath.row].qyName!
        cell?.pkLab.text = logDatas[indexPath.section].pkInfos[indexPath.row].pkName!
        
        cell?.qyImg.image = UIImage.init(named: "log_company")
        
        
        cell?.pkImg.image = UIImage.init(named: "log_vent")  //log_wash
        
        
        var aa = ""
        switch logType {
        case "1":
            aa = "数据超标时间段：点击查看"
            cell?.timeImg.image = UIImage.init(named: "log_overproof")
        case "2":
            aa = "数据异常时间段：点击查看"
            cell?.timeImg.image = UIImage.init(named: "log_exception")
        case "3":
            aa = "设备掉线时间段：点击查看"
            cell?.timeImg.image = UIImage.init(named: "log_outline")
        default:
            aa = "数据超标时间段：点击查看"
            cell?.timeImg.image = UIImage.init(named: "log_overproof")
        }
        cell?.dxTimeLab.text = aa
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertView(title: "时间段：", message: logDatas[indexPath.section].pkInfos[indexPath.row].offTime!, delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
    }
}
