//
//  HMStatisticsController.swift
//  HMonitor
//
//  Created by apple on 2018/6/23.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import Charts
import PGDatePicker

class HMStatisticsController: WBBaseViewController,JTSegmentControlDelegate,ChartViewDelegate,PGDatePickerDelegate {
   
    let cellId = "cellID"
    var titles : [String] = []
    var yzIds : [String] = []
    var type = "1"
    var popMenu:SwiftPopMenu!
    var yzId : String?   ///因子id
    var charType :String?   ///事件类型
    var startTime : String?
    var endTime : String?
    var tjType = "区域"     //统计类型
    
    var qyDatas : [TjQyData] = []
    
    var sjData1 : [TjDataSjData] = []    //区域统计数据
    var sjData2 : [TjDataSjData] = []    //流域
    var sjData3 : [TjDataSjData] = []    //重点
    
    
    //初始化控件
    lazy var pieChartView = PieChartView()
    lazy var dateBtn = UIButton()
    lazy var zhongdianBtn = UIButton()
    lazy var liuyuBtn = UIButton()
    lazy var quyuBtn = UIButton()
    let tableView = UITableView()
    let sView = UIView()
    let dView = UIView()
    let pLabel = UILabel()
    
    override func setupUI() {
        super.setupUI()
        print("统计分析")
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "时间"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(showPop))
        
        addSegmented()
        addUI()
        
        loadYzType()
    }
    
    override func segementDidchange(segmented: UISegmentedControl) {
        type = "\(segmented.selectedSegmentIndex+1)"
        loadYzType()
    }
    
    //MARK: 添加因子视图
    func addUI(){
        self.view.addSubview(sView)
        sView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(44)
            make.top.equalTo(segmented.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
        
        self.view.addSubview(dView)
        dView.backgroundColor = UIColor.cz_color(withHex: 0xEFEFF4)
        dView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(44)
            make.top.equalTo(sView.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
        
       self.dView.addSubview(pLabel)
        pLabel.snp.makeConstraints { (make) in
            make.width.equalTo(130)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
        pLabel.text = "排放量 单位 T"
        pLabel.textAlignment = .center
        
        self.dView.addSubview(dateBtn)
        dateBtn.setTitleColor(UIColor.darkGray, for: [])
        dateBtn.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.right.equalToSuperview().offset(10)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
        
        
        self.view.addSubview(pieChartView)
        pieChartView.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.top.equalTo(dView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
        }
        
        self.view.addSubview(quyuBtn)
        quyuBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(dView.snp.bottom).offset(15)
            make.left.equalTo(pieChartView.snp.right).offset(15)
        }
        self.view.addSubview(liuyuBtn)
        liuyuBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(quyuBtn.snp.bottom).offset(15)
            make.left.equalTo(pieChartView.snp.right).offset(15)
        }
        self.view.addSubview(zhongdianBtn)
        zhongdianBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(liuyuBtn.snp.bottom).offset(15)
            make.left.equalTo(pieChartView.snp.right).offset(15)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(200)
            make.top.equalTo(pieChartView.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "HMTjCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        //获取当前时间
        let now = Date()
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        startTime = "\(dformatter.string(from: now))"
        endTime = ""
        dateBtn.setTitle(startTime, for: [])
        charType = "0"
        pieChartView.delegate = self
        
        quyuBtn.addTarget(self, action: #selector(quYuBtnClick), for: .touchUpInside)
        liuyuBtn.addTarget(self, action: #selector(liuYuBtnClick), for: .touchUpInside)
        zhongdianBtn.addTarget(self, action: #selector(zhongdianBtnClick), for: .touchUpInside)
        
        quyuBtn.setTitle("区域", for: [])
        liuyuBtn.setTitle("流域", for: [])
        zhongdianBtn.setTitle("重点", for: [])
        quyuBtn.setTitleColor(UIColor.darkGray, for: [])
        liuyuBtn.setTitleColor(UIColor.darkGray, for: [])
        zhongdianBtn.setTitleColor(UIColor.darkGray, for: [])
        
        dateBtn.addTarget(self, action: #selector(timeBtnClick), for: .touchUpInside)
    }
    
    //MARK: 获取统计数据
    func loadTjData(){
        
        print(userAccnum!)
        print(ten!)
        print(charType!)
        print(startTime!)
        print(endTime!)
        
        WZNetworkTool.shareNetworkTool.loadTjData(userAccnum: userAccnum!, token: ten!, charType: charType!, startTime: startTime!, endTime: endTime!, acode: aCode!, wrwName: yzId!) { (objInfo) in
            print(objInfo.data.count,objInfo.data[0].sjData.count)
            
            self.sjData1 = objInfo.data[0].sjData
            self.sjData2 = objInfo.data[1].sjData
            self.sjData3 = objInfo.data[2].sjData
            
            self.setChart()
            
            self.loadQyData(num: objInfo.data[0].sjData[0].num!, type: "1", code: objInfo.data[0].sjData[0].code!)
        }
    }
    
    //MARK: 获取企业数据
    func loadQyData(num : String,type:String,code:String){
        WZNetworkTool.shareNetworkTool.loadTjQyList(userAccnum: userAccnum!, token: ten!, charType: charType!, startTime: startTime!, endTime: endTime!, acode: aCode!, wrwName: yzId!, num: num, type: type, code: code) { (objInfo) in
            print(objInfo.data[0].name)
            self.qyDatas = objInfo.data!
            self.tableView.reloadData()
        }
    }
    
    //MARK: 获取因子类型
    func loadYzType(){
        WZNetworkTool.shareNetworkTool.loadTjYzType(userAccnum: userAccnum!, token: ten!, type: type) { (objInfo) in
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
            self.loadTjData()
           
        }
    }
    
    @objc func showPop(){
        popMenu = SwiftPopMenu(frame:  CGRect(x: screenWidth-160, y: 70, width: 150, height: 150), arrowMargin: 12)
        
        popMenu.popData = [(icon:"电话",title:"日"),
                           (icon:"电话",title:"月"),
                           (icon:"电话",title:"年")]
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            print("block select \(index)")
            self?.charType = "\(index)"
            //            self?.loadTjData()
            
        }
        popMenu.show()
    }
    
    func didSelected(segement: JTSegmentControl, index: Int) {
        print("current index \(index)")
        self.yzId = self.yzIds[index]
        self.loadTjData()
    }
    
    ///设置饼图数据
    func setChart() {
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        
        switch self.tjType {
        case "区域":
            for i in 0..<self.sjData1.count {
                let entry = PieChartDataEntry(value: Double(self.sjData1[i].value!)!, label: self.sjData1[i].name!) //设置数据 title和对应的值
                
                dataEntries.append(entry)
                colors.append(UIColor.randomColor)
            }
        case "流域":
            for i in 0..<self.sjData2.count {
                let entry = PieChartDataEntry(value: Double(self.sjData2[i].value!)!, label: self.sjData2[i].name!) //设置数据 title和对应的值
                
                dataEntries.append(entry)
                colors.append(UIColor.randomColor)
            }
        case "重点":
            for i in 0..<self.sjData3.count {
                let entry = PieChartDataEntry(value: Double(self.sjData3[i].value!)!, label: self.sjData3[i].name!) //设置数据 title和对应的值
                
                dataEntries.append(entry)
                colors.append(UIColor.randomColor)
            }
        default:
            break
        }
        
        //        for i in 0..<dataPoints.count {
        //            let entry = PieChartDataEntry(value: values[i], label: "\(dataPoints[i])") //设置数据 title和对应的值
        //
        //            dataEntries.append(entry)
        //        }
        
        
        let pichartDataSet = PieChartDataSet(values: dataEntries, label: "") //设置表示
        //设置饼状图字体配置
        setPieChartDataSetConfig(pichartDataSet: pichartDataSet)
        
        
        let pieChartData = PieChartData(dataSet: pichartDataSet)
        //设置饼状图字体样式
        setPieChartDataConfig(pieChartData: pieChartData)
        pieChartView.data = pieChartData //将配置及数据添加到表中
        
        
        //设置饼状图样式
        setDrawHoleState()
        
        
        
        pichartDataSet.colors = colors//设置区块颜色
    }
    
    //设置饼状图字体配置
    func setPieChartDataSetConfig(pichartDataSet: PieChartDataSet){
        pichartDataSet.sliceSpace = 0 //相邻区块之间的间距
        pichartDataSet.selectionShift = 8 //选中区块时, 放大的半径
        pichartDataSet.xValuePosition = .insideSlice //名称位置
        pichartDataSet.yValuePosition = .outsideSlice //数据位置
        //数据与区块之间的用于指示的折线样式
        pichartDataSet.valueLinePart1OffsetPercentage = 0.85 //折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        pichartDataSet.valueLinePart1Length = 0.5 //折线中第一段长度占比
        pichartDataSet.valueLinePart2Length = 0.4 //折线中第二段长度最大占比
        pichartDataSet.valueLineWidth = 1 //折线的粗细
        pichartDataSet.valueLineColor = UIColor.gray //折线颜色
        
        
    }
    
    //设置饼状图字体样式
    func setPieChartDataConfig(pieChartData: PieChartData){
        pieChartData.setValueFormatter(DigitValueFormatter())//设置百分比
        
        pieChartData.setValueTextColor(UIColor.gray) //字体颜色为白色
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 10))//字体大小
    }
    
    
    //设置饼状图中心文本
    func setDrawHoleState(){
        ///饼状图距离边缘的间隙
        pieChartView.setExtraOffsets(left: 30, top: 0, right: 30, bottom: 0)
        //拖拽饼状图后是否有惯性效果
        pieChartView.dragDecelerationEnabled = true
        //是否显示区块文本
        pieChartView.drawSlicesUnderHoleEnabled = true
        //是否根据所提供的数据, 将显示数据转换为百分比格式
        pieChartView.usePercentValuesEnabled = true
        
        // 设置饼状图描述
        pieChartView.chartDescription?.text = ""
        pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 10)
        pieChartView.chartDescription?.textColor = UIColor.gray
        
        // 设置饼状图图例样式
        pieChartView.legend.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        pieChartView.legend.formToTextSpace = 5 //文本间隔
        pieChartView.legend.font = UIFont.systemFont(ofSize: 10) //字体大小
        pieChartView.legend.textColor = UIColor.gray //字体颜色
        pieChartView.legend.verticalAlignment = .bottom //图例在饼状图中的位置
        pieChartView.legend.form = .circle //图示样式: 方形、线条、圆形
        pieChartView.legend.formSize = 12 //图示大小
        pieChartView.legend.orientation = .horizontal
        pieChartView.legend.horizontalAlignment = .center
        
        ////饼状图中心的富文本文本
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSAttributedStringKey.foregroundColor: UIColor.gray]
        
        let centerTextAttribute = NSAttributedString(string: tjType, attributes: attributes)
        pieChartView.centerAttributedText = centerTextAttribute
        
        
        
        /*
         ///设置饼状图中心的文本
         if pieChartView.isDrawHoleEnabled {
         ///设置饼状图中间的空心样式
         pieChartView.drawHoleEnabled = true //饼状图是否是空心
         pieChartView.holeRadiusPercent = 0.5 //空心半径占比
         pieChartView.holeColor = UIColor.clear //空心颜色
         pieChartView.transparentCircleRadiusPercent = 0.52 //半透明空心半径占比
         pieChartView.transparentCircleColor = UIColor(r: 210, g: 145, b: 165, 0.3) //半透明空心的颜色
         pieChartView.drawCenterTextEnabled = true //是否显示中间文字
         //普通文本
         //pieChartView.centerText = "平均库龄"
         //富文本
         let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSForegroundColorAttributeName: UIColor.red]
         let centerTextAttribute = NSAttributedString(string: "平均库龄", attributes: attributes)
         pieChartView.centerAttributedText = centerTextAttribute
         }
         */
        
        pieChartView.setNeedsDisplay()
        
        
    }
    
    //点击空白地区
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    //点击饼状图上的事件
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        var msg : String?
//        switch self.tjType {
//        case "区域":
//            msg = "\(sjData1[Int(highlight.x)])  值为： \(highlight.y)"
//        case "流域":
//            msg = "\(sjData1[Int(highlight.x)])  值为： \(highlight.y)"
//        case "重点":
//            msg = "\(sjData1[Int(highlight.x)])  值为： \(highlight.y)"
//        default:
//            msg = "\(sjData1[Int(highlight.x)])  值为： \(highlight.y)"
//            break
//        }
//        let al = UIAlertController.init(title: nil, message: msg, preferredStyle: .alert)
//        let cancel = UIAlertAction.init(title: "知道了", style: .cancel, handler: nil)
//        al.addAction(cancel)
//        self.present(al, animated: true, completion: nil)
    }
}

extension HMStatisticsController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HMTjCell
    
        cell.qyLabel.text = qyDatas[indexPath.row].name!
        var prog : Float?
        if qyDatas[indexPath.row].zdtype! == "" {
            prog = 0.0
        }else{
            prog = Float(qyDatas[indexPath.row].zdtype!)
        }
        cell.progressNum.setProgress(prog!, animated: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func timeBtnClick() {
        let datePickerManager = PGDatePickManager()
        let datePicker = datePickerManager.datePicker!
        datePicker.delegate = self
        datePicker.isHiddenMiddleText = false;
        datePicker.datePickerType = .type2;
        
        switch self.charType {
        case "0":
            datePicker.datePickerMode = .date
        case "1":
            datePicker.datePickerMode = .yearAndMonth
        case "2":
            datePicker.datePickerMode = .year
        default:
            datePicker.datePickerMode = .date
        }
        
        //        datePicker.datePickerMode = .date
        self.present(datePickerManager, animated: false, completion: nil)
    }
    
    func datePicker(_ datePicker: PGDatePicker!, didSelectDate dateComponents: DateComponents!) {
        switch self.charType {
        case "0":
            self.startTime = "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!)"
        case "1":
            self.startTime = "\(dateComponents.year!)-\(dateComponents.month!)"
        case "2":
            self.startTime = "\(dateComponents.year!)"
        default:
            self.startTime = "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!)"
        }
        dateBtn.setTitle(startTime, for: .normal)
        self.loadTjData()
    }
    
    @objc func quYuBtnClick() {
        self.tjType = "区域"
        self.setChart()
    }
    
    @objc func liuYuBtnClick() {
        self.tjType = "流域"
        self.setChart()
    }
    @objc func zhongdianBtnClick() {
        self.tjType = "重点"
        self.setChart()
    }
}

//转化为带%
class DigitValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueWithoutDecimalPart = String(format: "%.2f%%", value)
        return valueWithoutDecimalPart
        
    }
}

extension UIColor {
    //返回随机颜色
    class var randomColor:UIColor{
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
