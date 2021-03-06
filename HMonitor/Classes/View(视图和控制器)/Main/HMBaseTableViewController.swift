//
//  HMBaseTableViewController.swift
//  HMonitor
//
//  Created by apple on 2018/6/22.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import MJRefresh

class HMBaseTableViewController: UIViewController {

    /// 访客视图信息字典
    var visitorInfoDictionary: [String: String]?
    
    /// 表格视图 - 如果用户没有登录，就不创建
    var tableView: UITableView?
    /// 刷新控件
    //    var refreshControl: UIRefreshControl?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    /// 上拉刷新标记
    var isPullup = false
    
    /// 自定义导航条
    lazy var navigationBar = HMBaseNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        HMNetworkManager.shared.userLogon ? loadData() : ()
        
        // 注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loginSuccess),
            name: NSNotification.Name(rawValue: WBUserLoginSuccessedNotification),
            object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 重写 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    /// 加载数据 - 具体的实现由子类负责
    @objc func loadData() {
        // 如果子类不实现任何方法，默认关闭刷新控件
        
    }
    
    
    /// 登录成功处理
    @objc func loginSuccess(n: Notification) {
        
        print("登录成功 \(n)")
        
        // 登录前左边是注册，右边是登录
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        
        // 更新 UI => 将访客视图替换为表格视图
        // 需要重新设置 view
        // 在访问 view 的 getter 时，如果 view == nil 会调用 loadView -> viewDidLoad
        view = nil
        
        // 注销通知 -> 重新执行 viewDidLoad 会再次注册！避免通知被重复注册
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc  func login() {
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    @objc  func register() {
        print("用户注册")
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        // 取消自动缩进 - 如果隐藏了导航栏，会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
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
    
    
    /// 设置导航条
    func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将 item 设置给 bar
        navigationBar.items = [navItem]
        
        // 1> 设置 navBar 整个背景的渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 2> 设置 navBar 的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        
        
        // 3> 设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HMBaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误！
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
