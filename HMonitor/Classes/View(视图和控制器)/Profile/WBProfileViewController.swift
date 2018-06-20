//
//  WBProfileViewController.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

private let cellId = "cellId"
class WBProfileViewController: WBBaseViewController {
    var names = ["执法取证","预警消息","预警日志","意见反馈","关于环信云","清楚缓存"]
    var images = ["执法情况","预警消息","日志","意见反馈","关于我们","清除缓存"]
    
    let userImageView = UIImageView(image: UIImage(named: "timg"))
    let headView = UIView()
    let userNameLab = UILabel()
    override func setupTableView() {
        super.setupTableView()
        
        // 注册原型 cell
        tableView?.register(UINib(nibName: "HMProfileCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        tableView?.estimatedRowHeight = 300
        
        tableView?.rowHeight = 50
        
        setupHeader()
        
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

extension WBProfileViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
