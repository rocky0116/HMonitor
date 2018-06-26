//
//  WBHomeViewController.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import SGPagingView
import RxSwift
import RxCocoa

class WBHomeViewController: WBBaseViewController {

    ///标题内容
    private var pageTitleView: SGPageTitleView?
    private var pagecontentView: SGPageContentView?
    
    override func setupUI() {
        super.setupUI()
        setupNavTitle()
        addSegmented()
    }
    
    override func segementDidchange(segmented: UISegmentedControl) {
        print("首页选择",segmented.selectedSegmentIndex)
        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex))
    }
}



// MARK: - 设置界面
extension WBHomeViewController {
    
    /// 设置导航栏标题
     func setupNavTitle() {
        
        let title = HMNetworkManager.shared.userAccount.screen_name == nil ? "首页" : HMNetworkManager.shared.userAccount.screen_name
        
        let button = UIButton()
        button.setTitle(title, for: [])
        button.setImage(UIImage(named: "定位"), for: [])
        button.setTitleColor(UIColor.darkGray, for: [])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        navItem.titleView = button
        
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
        
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "切换"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(switchQy))
    }
    
    //MARK: 跳转到城市区域列表
    @objc func clickTitleButton(btn: UIButton) {
//        let vc = HMCityController()
        // push 的动作是 nav 做的
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = UINavigationController(rootViewController: HMCityController())
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: 切换到企业列表
    @objc func switchQy() {
        let vc = WBDemoViewController()
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }
}
