//
//  LoginView.swift
//  hxlhEmep
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var pwdText: UITextField!
    
    @IBOutlet weak var codeBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func getCodeClick(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction func getLoginClick(_ sender: Any) {
        //登录通知
        
        if userNameText.text! == nil && userNameText.text! == "" {
            let alert = UIAlertView(title: "温馨提示", message: "请输入用户名", delegate: nil, cancelButtonTitle: "知道了")
            alert.show()
            return
        }
        if pwdText.text! == nil && pwdText.text! == "" {
            let alert = UIAlertView(title: "温馨提示", message: "请输入密码", delegate: nil, cancelButtonTitle: "知道了")
            alert.show()
            return
        }
        
        WZNetworkTool.shareNetworkTool.loadLogin(userAccnum: userNameText.text!, pwd: pwdText.text!) { (userInfo) in
            
            if userInfo.status == 0 {
                print(userInfo.data.user.areaCode!)
                let userDefault = UserDefaults.standard
                userDefault.set(self.userNameText.text!, forKey: userName)
                userDefault.set(userInfo.data.user.areaCode!, forKey: areaCode)
                userDefault.set(userInfo.data.area.areaName, forKey: city)
                userDefault.set(userInfo.token!, forKey: token)
                userDefault.synchronize()
                
                ///登录成功，发送通知
                NotificationCenter.default.post(name: NSNotification.Name(WBUserShouldLoginNotification), object: nil)
                
                self.removeFromSuperview()
            }else{
                let alert = UIAlertView(title: "温馨提示", message: userInfo.message, delegate: nil, cancelButtonTitle: "知道了")
                alert.show()
            }
            
        }
        
        
    }
    
    class func sLoginView() -> LoginView {
        let nib = UINib(nibName: "LoginView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! LoginView
        //从xib 加载的视图，默认是 600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
}
