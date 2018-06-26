//
//  WBProfileViewController.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import MJRefresh

private let cellId = "cellId"
class WBProfileViewController: WBBaseViewController {
    var names = ["执法取证","预警消息","预警日志","意见反馈","关于环信云","清楚缓存"]
    var images = ["执法情况","预警消息","日志","意见反馈","关于我们","清除缓存"]
    
    let userImageView = UIImageView(image: UIImage(named: "timg"))
    let headView = UIView()
    let userNameLab = UILabel()
    /// 表格视图 - 如果用户没有登录，就不创建
    var tableView: UITableView?
    /// 刷新控件
    //    var refreshControl: UIRefreshControl?
   
    override func setupUI() {
        super.setupUI()
        print("个人中心")
        setupTableView()
    }
   
    /// 设置表格视图 - 用户登录之后执行
    /// 子类重写此方法，因为子类不需要关心用户登录之前的逻辑
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源&代理 -> 目的：子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: 40,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        
        // 修改指示器的缩进 - 强行解包是为了拿到一个必有的 inset
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        // 设置刷新控件
        // 1> 实例化控件
        refresh()
        
        // 注册原型 cell
        tableView?.register(UINib(nibName: "HMProfileCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        tableView?.estimatedRowHeight = 300
        
        tableView?.rowHeight = 50
        
        setupHeader()
    }
    
    
    func refresh(){
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        tableView?.mj_header = header
        tableView?.mj_footer = footer
        
    }
    
    @objc func headerRefresh(){
        tableView?.mj_header.endRefreshing()//结束头部刷新
        loadData()
        print("刷新")
    }
    
    @objc func footerRefresh(){
        loadData()
        tableView?.mj_footer.endRefreshing()//结束尾部刷新
        print("加载")
    }
    
    func setupHeader(){
        headView.frame = CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 180)
        headView.backgroundColor = UIColor.init(red: 71/225, green: 162/225, blue: 223/225, alpha: 1)
        
        
        userImageView.frame = CGRect(x: (UIScreen.cz_screenWidth()-70)/2, y: 30, width: 70, height: 70)
        
        userNameLab.frame = CGRect(x: 0, y: Int(userImageView.frame.maxY+10), width: Int(UIScreen.cz_screenWidth()), height: 30)
        userNameLab.textAlignment = .center
        
        userNameLab.text = "用户名"
        userNameLab.textColor = UIColor.white
        headView.addSubview(userImageView)
        headView.addSubview(userNameLab)
        
        tableView?.tableHeaderView = headView
        
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
//        switch indexPath.row {
//        case 0:
//            if let takeCV = storyboard?.instantiateViewController(withIdentifier: "TakeCV") as? TakeController{
//                self.navigationController?.pushViewController(takeCV, animated: true)
//            }
//        case 1:
//            if let messageCV = storyboard?.instantiateViewController(withIdentifier: "messageCV") as? MessageController{
//                self.navigationController?.pushViewController(messageCV, animated: true)
//            }
//        case 2:
//            if let logCV = storyboard?.instantiateViewController(withIdentifier: "logCV") as? WarnLogController{
//                self.navigationController?.pushViewController(logCV, animated: true)
//            }
//        case 3:
//            print("ideaCV")
//            if let ideaCV = storyboard?.instantiateViewController(withIdentifier: "ideaCV") as? IdeaController{
//                self.navigationController?.pushViewController(ideaCV, animated: true)
//            }
//        case 4:
//            if let aboutmCV = storyboard?.instantiateViewController(withIdentifier: "AboutmeController") as? AboutMeViewController{
//                self.navigationController?.pushViewController(aboutmCV, animated: true)
//            }
//        case 5:
//            let alert = UIAlertView(title: "温馨提示", message: "清除成功", delegate: nil, cancelButtonTitle: "知道了")
//            alert.show()
//        case 6:
//            print("dianjiasfdafa")
//        default:
//            print("0000000")
//        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
