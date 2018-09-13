//
//  WBProfileViewController.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftProgressHUD

private let cellId = "cellId"
class WBProfileViewController: WBBaseViewController {
    var names = ["执法取证","预警消息","预警日志","意见反馈","关于环信云","清楚缓存"]
    var images = ["执法情况","预警消息","日志","意见反馈","关于我们","清除缓存"]
    
    let userImageView = UIImageView(image: UIImage(named: "timg"))
    let headView = UIView()
    let userNameLab = UILabel()
    
    lazy var tableView = UITableView()
    lazy var exitBtn = UIButton()
   
    override func setupUI() {
        super.setupUI()
        print("个人中心")
        setupTableView()
    }
   
   
    func setupTableView() {
        self.view.addSubview(exitBtn)
        exitBtn.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalToSuperview().offset(-100)
        }
        exitBtn.backgroundColor = UIColor.init(red: 71/225, green: 162/225, blue: 223/225, alpha: 1)
        exitBtn.setTitle("退出登录", for: [])
        exitBtn.setTitleColor(UIColor.white, for: [])
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.top.equalTo(navigationBar.snp.bottom).offset(0)
            make.bottom.equalTo(exitBtn.snp.top).offset(-20)
        }
        // 设置数据源&代理 -> 目的：子类直接实现数据源方法
        tableView.dataSource = self
        tableView.delegate = self
        
     
        refresh()
        
        // 注册原型 cell
        tableView.register(UINib(nibName: "HMProfileCell", bundle: nil), forCellReuseIdentifier: cellId)
        setupHeader()
    }
    
    
    func refresh(){
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        
    }
    
    @objc func headerRefresh(){
        tableView.mj_header.endRefreshing()//结束头部刷新
    }
    
    
    func setupHeader(){
        headView.frame = CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 150)
        headView.backgroundColor = UIColor.init(red: 71/225, green: 162/225, blue: 223/225, alpha: 1)
        
        
        userImageView.frame = CGRect(x: (UIScreen.cz_screenWidth()-70)/2, y: 20, width: 70, height: 70)
        
        userNameLab.frame = CGRect(x: 0, y: Int(userImageView.frame.maxY+10), width: Int(UIScreen.cz_screenWidth()), height: 30)
        userNameLab.textAlignment = .center
        
        userNameLab.text = "用户名"
        userNameLab.textColor = UIColor.white
        headView.addSubview(userImageView)
        headView.addSubview(userNameLab)
        
        tableView.tableHeaderView = headView
        
        footer.isHidden = true
    }

}

extension WBProfileViewController: UITableViewDataSource,UITableViewDelegate{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HMProfileCell
        
        cell?.pImg.image = UIImage(named: images[indexPath.row])
        cell?.pNameLab.text = names[indexPath.row]
        
        
        // 3. 返回 cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc : WBBaseViewController?
        switch indexPath.row {
        case 0:
            vc = HMTakeController()
        case 1:
            vc = HMMessageController()
        case 2:
            vc = HMLogController()
        case 3:
            vc = HMFeedBackController()
        case 4:
            vc = HMAboutController()
        case 5:
            SwiftProgressHUD.showSuccess("清除成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SwiftProgressHUD.hideAllHUD()
            }
            return
        
        default:
            return
        }
        
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc!, animated: true)
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
