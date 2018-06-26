//
//  WBOAuthViewController.swift
//  传智微博
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import SwiftProgressHUD

/// 通过 webView 加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    
    func setUPUI() {
        
        view.backgroundColor = UIColor.white
        
     
        // 设置导航栏
        title = "登录"
        // 导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", target: self, action: #selector(toRegistor))
    }
    
    @objc func toRegistor(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        let v =  LoginView.sLoginView()
        view.addSubview(v)
    }
    
    // MARK: - 监听方法
    /// 关闭控制器
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
   
}

