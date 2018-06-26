//
//  HMQyYZDetailController.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import Charts

class HMQyYZDetailController: WBBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var tjYzDatas : [YzDetailMonitorData] = []
    var yzDatas : [YzDetailMonitorData] = []
   
    var qyId : String?
    var pkId : String?
    var yzId : String?
    var page = 1
    var dataType = "0"
    var dateType = "0"
    var yzType : String?
    
    var titles : [String] = []
    var yzIds : [String] = []
    
    lazy var lineChartView = LineChartView()
    
    lazy var tableView = UITableView()
    lazy var dataTypeButton = UIButton()
    let Titems = ["48小时","7天","30天","1年"]
    
    lazy var choicTimeSegemnt = UISegmentedControl(items: Titems)
    lazy var qyInfoLab = UILabel()
    
    lazy var view1 = UIView()
    lazy var historyLab = UILabel()
    lazy var view2 = UIView()
    lazy var lab1 = UILabel()
    lazy var lab2 = UILabel()
    lazy var img = UIImageView()
    
    var popMenu:SwiftPopMenu!
    override func setupUI() {
        super.setupUI()
        title = "因子详情"
        
        addUI()
        showTjData()
        loadYzType()
        initChart()
        refresh()
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "电话"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(yzTypeClick))
    }
    
    //MARK: 添加UI
    func addUI() -> () {
        self.view.addSubview(qyInfoLab)
        qyInfoLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
            make.top.equalTo(navigationBar.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
        }
        self.view.addSubview(choicTimeSegemnt)
        choicTimeSegemnt.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.height.equalTo(30)
            make.top.equalTo(qyInfoLab.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        choicTimeSegemnt.addTarget(self, action: #selector(segmentedControlChanged), for: UIControlEvents.valueChanged)
        
        self.view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.top.equalTo(choicTimeSegemnt.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(10)
        }
        
        self.view.addSubview(view1)
        view1.backgroundColor = UIColor.cz_color(withHex: 0xEFEFF4)
        view1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(40)
            make.top.equalTo(lineChartView.snp.bottom).offset(15)
        }
        self.view1.addSubview(historyLab)
        historyLab.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(lineChartView.snp.bottom).offset(15)
        }
        
        self.view.addSubview(view2)
        view2.backgroundColor = UIColor.cz_color(withHex: 0xEFEFF4)
        view2.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(40)
            make.top.equalTo(view1.snp.bottom).offset(15)
        }
        self.view2.addSubview(lab1)
        lab1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/2)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(view1.snp.bottom).offset(15)
        }
        self.view2.addSubview(lab2)
        lab2.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth/2)
            make.height.equalTo(40)
            make.left.equalTo(lab1.snp.right).offset(0)
            make.top.equalTo(view1.snp.bottom).offset(15)
        }
       
        
        lab1.textAlignment = .center
        lab2.textAlignment = .center
        
        historyLab.text = "历史数据"
        lab1.text = "实时数据"
        lab2.text = "因子类型"
       
        lab1.font = UIFont.systemFont(ofSize: 14)
        lab2.font = UIFont.systemFont(ofSize: 14)
        historyLab.font = UIFont.systemFont(ofSize: 14)
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(300)
            make.top.equalTo(view2.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "HMYzCell", bundle: nil), forCellReuseIdentifier: "CellID")
    }
    
    //MARK:添加因子数据列表
    func loadYzType(){
        WZNetworkTool.shareNetworkTool.loadDataYzType(userAccnum: userAccnum!, token: ten!, type: yzType!) { (objInfo) in
            self.titles.removeAll()
            self.yzIds.removeAll()
            
            print(objInfo.data.monitorData.count)
            for ss in objInfo.data.monitorData {
                self.titles.append(ss.monitorName)
                self.yzIds.append(ss.monitorId)
            }
        }
    }
    
    //MARK: 添加因子统计和实时数据列表
    func showTjData(){
        WZNetworkTool.shareNetworkTool.loadYzDetail(userAccnum: userAccnum!, token: ten!, companyId: qyId!, outletId: pkId!, monitorId: yzId!, page: "\(page)", dataType: dataType, dateType: dateType) { (objInfo) in
            self.tjYzDatas = objInfo.data.monitorData!
            self.yzDatas = objInfo.data.monitorDataList!
            
            self.qyInfoLab.text = objInfo.data.companyName! + "/" + objInfo.data.outletName!
            
            //YzDetailMonitorData
            var months : [String] = []
            var unitsSold : [Double] = []
            for item in self.tjYzDatas {
                let str = item.dateTime!
                var result = ""  //2018-05-22 19:52:00
                switch self.dateType {
                case "0":
                    //"abcdefghi"
                    let startIndex = str.index(str.startIndex, offsetBy:11)//获取d的索引
                    let endIndex = str.index(startIndex, offsetBy:2)//从d的索引开始往后两个,即获取f的索引
                    result = str.substring(with: startIndex..<endIndex) + "时"//输出d的索引到f索引的范围,注意..<符号表示输出不包含f
                    //打印结果为de
                    print(result)
                    break
                    
                default:
                    let startIndex = str.index(str.startIndex, offsetBy:5)//获取d的索引
                    let endIndex = str.index(startIndex, offsetBy:5)//从d的索引开始往后两个,即获取f的索引
                    result = str.substring(with: startIndex..<endIndex)//输出d的索引到f索引的范围,注意..<符号表示输出不包含f
                    //打印结果为de
                    print(result)
                    break
                }
                
                
                months.append(result)
                if item.value! == ""{
                    unitsSold.append(0.0)
                }else{
                    unitsSold.append(Double(item.value!)!)
                }
            }
            if months.count > 0 {
                self.setChart(months, values: unitsSold)
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: 添加列表刷新
    func refresh(){
        // 下拉刷新
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        
        self.tableView.mj_header = header
        self.tableView.mj_footer = footer
        
    }
    
    @objc func headerRefresh(){
        self.tableView.mj_header.endRefreshing()//结束头部刷新
        page = 1
        showTjData()
    }
    
    @objc func footerRefresh(){
        page = page + 1
        self.tableView.mj_footer.endRefreshing()//结束尾部刷新
        showTjData()
    }
    
    @objc func segmentedControlChanged(sender:UISegmentedControl) {
        dateType = "\(sender.selectedSegmentIndex)"
        showTjData()
    }
    
    func initChart(){
        //右下角图标描述
        lineChartView.chartDescription?.text = ""
        lineChartView.legend.textColor = YHuiColor()
        
        //设置X轴坐标
        
        lineChartView.xAxis.granularity = 1.0
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.axisLineColor = YHuiColor()
        lineChartView.xAxis.labelTextColor = YHuiColor()
        lineChartView.xAxis.labelCount = 7
        
        //设置Y轴坐标
        //        lineChart.rightAxis.isEnabled = false
        //不显示右侧Y轴
        lineChartView.rightAxis.drawAxisLineEnabled = false
        //不显示右侧Y轴数字
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.axisLineColor = YHuiColor()
        lineChartView.leftAxis.gridColor = YHuiColor()
        lineChartView.leftAxis.labelTextColor = YHuiColor()
        
        //设置双击坐标轴是否能缩放
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        
        
        
        
        
    }
    
    //设置charts方法
    func setChart(_ dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "单位：t")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChartView.data = lineChartData
        //外圆
        lineChartDataSet.setCircleColor(YLineYYColor())
        //画外圆
        //        lineChartDataSet.drawCirclesEnabled = true
        //内圆
        lineChartDataSet.circleHoleColor = YLineYNColor()
        //画内圆
        //        lineChartDataSet.drawCircleHoleEnabled = true
        
        //线条显示样式
        //        lineChartDataSet.lineDashLengths = [1,3,4,2]
        //        lineChartDataSet.lineDashPhase = 0.5
        lineChartDataSet.colors = [YHuiColor()]
        
        //线条上的文字
        lineChartDataSet.valueColors = [YHuiColor()]
        //显示
        //        lineChartDataSet.drawValuesEnabled = true
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        //添加显示动画
        lineChartView.animate(xAxisDuration: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yzDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HMYzCell
        
        cell.dateLab.text = yzDatas[indexPath.row].dateTime!
        cell.valueLab.text = yzDatas[indexPath.row].value!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @objc func dataTypeClick(){
        popMenu = SwiftPopMenu(frame:  CGRect(x: tableView.frame.minX, y: tableView.frame.minY, width: 150, height: 150), arrowMargin: 12)
        
        popMenu.popData = [(icon:"电话",title:"实时数据"),
                           (icon:"电话",title:"时均数据"),
                           (icon:"电话",title:"日均数据")]
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            print("block select \(index)")
            self?.dateType = "\(index)"
            self?.showTjData()
            
        }
        popMenu.show()
    }
    
    @objc func yzTypeClick(){
        let hh = self.titles.count * 40
        
        
        popMenu = SwiftPopMenu(frame:  CGRect(x: Int(screenWidth-210), y: 70, width: 200, height: hh), arrowMargin: 12)
        
        var yzData:[(icon:String,title:String)]! = []
        for ss in self.titles{
            yzData.append((icon: "电话", title: ss))
        }
        
        popMenu.popData = yzData
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            print("block select \(index)")
            self?.yzId = self?.yzIds[index]
            self?.showTjData()
            
        }
        popMenu.show()
    }
    
   

}
