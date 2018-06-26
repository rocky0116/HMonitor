//
//  HMTakeController.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import Photos

class HMTakeController: WBBaseViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    lazy var tableView = UITableView()
    lazy var view1 = UIView()
    lazy var label = UILabel()
    lazy var zImg = UIImageView(image: UIImage(named: "全屏"))
    
    
    var qyDatas : [TakeData] = []
    
    var qipkname = ""
    
    override func setupUI() {
        super.setupUI()
        title = "执法取证"
        addUi()
        loadTake()
    }
    
    //MARK: 添加ui
    func addUi(){
        self.view.addSubview(view1)
        view1.backgroundColor = UIColor.cz_color(withHex: 0xEFEFF4)
        view1.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(44)
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(0)
        }
        self.view1.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth-100)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        label.text = "非企业单位执法取证"
        
        self.view1.addSubview(zImg)
        zImg.snp.makeConstraints { (make) in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(fTakeClick))
        zImg.addGestureRecognizer(singleTap)
        zImg.isUserInteractionEnabled = true
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight - 100)
            make.top.equalTo(view1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorInset = UIEdgeInsets.zero
//        tableView.layoutMargins = UIEdgeInsets.zero
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
    }
    
    func loadTake(){
        WZNetworkTool.shareNetworkTool.loadTake(userAccnum: userAccnum!, token: ten!, acode: aCode!) { (objInfo) in
            self.qyDatas = objInfo.data.data!
            self.tableView.reloadData()
        }
    }
    
    @objc func fTakeClick() {
        qipkname = "非企业单位执法取证"
        camera()
    }
    
    //调用照相机方法
    var pick : UIImagePickerController?
    
    func camera(){
        
        pick = UIImagePickerController()
        
        pick?.delegate = self
        
        pick?.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(pick!, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        pick?.dismiss(animated: true, completion: nil)
        //        img2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: (image?.drawTextInImage(qypkName: self.qipkname))!)
        }) { (isSuccess: Bool, error: Error?) in
            if isSuccess {
                //                let alert = UIAlertView(title: "温馨提示", message: "取证完成！", delegate: nil, cancelButtonTitle: "知道了")
                //                alert.show()
                print("取证完成")
            } else{
                //                let alert = UIAlertView(title: "温馨提示", message: "取证失败！", delegate: nil, cancelButtonTitle: "知道了")
                //                alert.show()
                print("取证失败")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return qyDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qyDatas[section].pkxx.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tview = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        let qyNameLab = UILabel(frame: CGRect(x: 5, y: 5, width: screenWidth-50, height: 40))
        qyNameLab.text = qyDatas[section].qyName!
        qyNameLab.textColor = YHuiColor()
        qyNameLab.font = UIFont.systemFont(ofSize: 14)
        
        let leftImg = UIImageView(image: UIImage(named: "icon_down"))
        leftImg.frame = CGRect(x: screenWidth-50, y: 10, width: 20, height: 20)
        
        tview.addSubview(qyNameLab)
        tview.addSubview(leftImg)
        return tview
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let pkNameView = UILabel(frame: CGRect(x: 20, y: 5, width: screenWidth-80, height: 30))
        pkNameView.text = qyDatas[indexPath.section].pkxx[indexPath.row].pkName!
        pkNameView.font = UIFont.systemFont(ofSize: 14)
        cell.addSubview(pkNameView)
        
        
        let leftImg = UIImageView(image: UIImage(named: "全屏"))
        leftImg.frame = CGRect(x: screenWidth-50, y: 10, width: 20, height: 20)
        
        cell.addSubview(leftImg)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        qipkname = "\(qyDatas[indexPath.section].qyName!)/\(qyDatas[indexPath.section].pkxx[indexPath.row].pkName!)"
        camera()
    }

}
