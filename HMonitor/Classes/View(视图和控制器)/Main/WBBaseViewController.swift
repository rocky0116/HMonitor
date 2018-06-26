//
//  WBBaseViewController.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

/// 所有主控制器的基类控制器
class WBBaseViewController: UIViewController {
    
    /// 访客视图信息字典
    var visitorInfoDictionary: [String: String]?
    /// 自定义导航条
    lazy var navigationBar = HMBaseNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    lazy var navItem = UINavigationItem()
    
    let aCode = UserDefaults.standard.string(forKey: areaCode)
    let userAccnum = UserDefaults.standard.string(forKey: userName)
    let ten = UserDefaults.standard.string(forKey: token)
    let aCity = UserDefaults.standard.string(forKey: city)
    
    let items = ["废气源","废水源"]
    
    lazy var segmented = UISegmentedControl(items: items)
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
        
    }
    
    
    /// 重写 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    //MARK: 加载数据 - 具体的实现由子类负责
    @objc func loadData() {
        // 如果子类不实现任何方法，默认关闭刷新控件
        
    }

    //MARK: 设置布局
    func setupUI() {
        view.backgroundColor = UIColor.white
        // 取消自动缩进 - 如果隐藏了导航栏，会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
    }
    
    //MARK: 设置导航条
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
        navigationBar.tintColor = UIColor.cz_color(withHex: 0x1CA3E5)
    }
    
    //MARK:添加选型卡
    func addSegmented(){
        ///设置选型卡
//        let segmented = UISegmentedControl(items: items)
        
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(segementDidchange), for: UIControlEvents.valueChanged)
        
        self.view.addSubview(segmented)
        
        segmented.snp.makeConstraints { (make) in
            make.width.equalTo(130)
            make.height.equalTo(30)
            make.top.equalTo(navigationBar.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
    }
    
    @objc func segementDidchange(segmented:UISegmentedControl){
       
    }
}


