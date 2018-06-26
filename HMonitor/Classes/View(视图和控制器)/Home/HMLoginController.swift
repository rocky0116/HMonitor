//
//  HMLoginController.swift
//  HMonitor
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import SwiftProgressHUD

class HMLoginController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var pwdEdit: UITextField!
    @IBOutlet weak var userEdit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginClick(_ sender: Any) {
        
        if (userEdit.text?.isEmpty)! {
            SwiftProgressHUD.showInfo("请输入用户名")
            closeProgress()
            return
        }
        if (pwdEdit.text?.isEmpty)! {
           
            SwiftProgressHUD.showInfo("请输入密码")
            closeProgress()
            return
        }
        
        WZNetworkTool.shareNetworkTool.loadLogin(userAccnum: userEdit.text!, pwd: pwdEdit.text!) { (userInfo) in
            
            if userInfo.status == 0 {
                print(userInfo.data.user.areaCode!)
                let userDefault = UserDefaults.standard
                userDefault.set(self.userEdit.text!, forKey: userName)
                userDefault.set(userInfo.data.user.areaCode!, forKey: areaCode)
                userDefault.set(userInfo.data.area.areaName, forKey: city)
                userDefault.set(userInfo.token!, forKey: token)
                userDefault.synchronize()
                
                ///登录成功
               self.present(WBMainViewController(), animated: true, completion: nil)
            }else{
                SwiftProgressHUD.showFail(userInfo.message)
            }
            self.closeProgress()
            
        }
    }
    
    func closeProgress(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {SwiftProgressHUD.hideAllHUD()}
    }

}
