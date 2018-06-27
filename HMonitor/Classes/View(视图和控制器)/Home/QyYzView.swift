//
//  QyYzView.swift
//  hxlhEmep
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class QyYzView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var qyNameLab: UILabel!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var qyInfoDatas : [HomeQyInfoCompanyData] = []
    var pkType : String?
//    var qyId:String?
    
    class func sQyView() -> QyYzView {
        let nib = UINib(nibName: "QyYzView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! QyYzView
        //从xib 加载的视图，默认是 600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
    
    func showData(model: HomeQyInfoData){
        qyNameLab.text = model.companyName
        qyInfoDatas = model.companyData

        //给表格视图添加代理
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.delegate = self
        tableView.dataSource = self
        
        //给关闭图片设置点击事件
        closeImg.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(taphandler))
        closeImg.addGestureRecognizer(tapGR)
    }
    
    @objc func taphandler(){
        removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyInfoDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let pkNameView = UILabel(frame: CGRect(x: 0, y: 5, width: (screenWidth-30)/3, height: 30))
        pkNameView.text = qyInfoDatas[indexPath.row].outletName!
        pkNameView.textAlignment = .center
        pkNameView.font = UIFont.boldSystemFont(ofSize: 12)
        pkNameView.textColor = UIColor.darkGray
        cell.addSubview(pkNameView)
        
        let dbNameView = UILabel(frame: CGRect(x: pkNameView.frame.maxX, y: 5, width: (screenWidth-30)/3, height: 30))
        if pkType == "1" {
            dbNameView.text = "排气口"
        }else{
            dbNameView.text = "排水口"
        }
        dbNameView.textAlignment = .center
        dbNameView.font = UIFont.boldSystemFont(ofSize: 12)
        dbNameView.textColor = UIColor.darkGray
        cell.addSubview(dbNameView)
        
        let sbStatuNameView = UILabel(frame: CGRect(x: dbNameView.frame.maxX, y: 5, width: (screenWidth-30)/3, height: 30))
        if qyInfoDatas[indexPath.row].isEquipmentDx! {
            sbStatuNameView.text = "掉线"
        }else if qyInfoDatas[indexPath.row].isEquipmentYc!{
            sbStatuNameView.text = "异常"
        }else{
            sbStatuNameView.text = "正常"
        }
        sbStatuNameView.textAlignment = .center
        sbStatuNameView.font = UIFont.boldSystemFont(ofSize: 12)
        sbStatuNameView.textColor = UIColor.darkGray
        cell.addSubview(sbStatuNameView)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         ///发送通知，跳转到企业排口详情页
        
        NotificationCenter.default.post(name: NSNotification.Name(GoUpQyYzListy), object: self, userInfo: ["outletId" : qyInfoDatas[indexPath.row].outletId])
        removeFromSuperview()
    }
    
    
}


