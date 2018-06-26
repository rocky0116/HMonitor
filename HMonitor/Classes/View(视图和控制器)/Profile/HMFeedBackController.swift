//
//  HMFeedBackController.swift
//  HMonitor
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import SwiftProgressHUD
import Photos
import BSImagePicker
class HMFeedBackController: WBBaseViewController ,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    lazy var headView = UIView()
    lazy var contentTxt = UITextField()
    lazy var img1 = UIImageView(image: UIImage(named: "idea_add"))
    lazy var img2 = UIImageView(image: UIImage(named: "idea_no"))
    lazy var img3 = UIImageView(image: UIImage(named: "idea_no"))
    lazy var img4 = UIImageView(image: UIImage(named: "idea_no"))
    lazy var img5 = UIImageView(image: UIImage(named: "idea_no"))
    lazy var imgDecLad = UILabel()
    lazy var qqTxt = UITextField()
    lazy var commitBtn = UIButton()
    lazy var myLad = UILabel()
    lazy var tableView = UITableView()
    
    var ideas : [IdeaData] = []
    var images : [UIImage] = []
    override func setupUI() {
        super.setupUI()
        title = "意见反馈"
        addUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(browserPhoto),
            name: NSNotification.Name(rawValue: WBStatusCellBrowserPhotoNotification),
            object: nil)
    }
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 浏览照片通知监听方法
    @objc func browserPhoto(n: Notification) {
        
        // 1. 从 通知的 userInfo 提取参数
        guard let selectedIndex = n.userInfo?[WBStatusCellBrowserPhotoSelectedIndexKey] as? Int,
            let urls = n.userInfo?[WBStatusCellBrowserPhotoURLsKey] as? [String],
            let imageViewList = n.userInfo?[WBStatusCellBrowserPhotoImageViewsKey] as? [UIImageView]
            else {
                return
        }
        
        // 2. 展现照片浏览控制器
        let vc = HMPhotoBrowserController.photoBrowser(
            withSelectedIndex: selectedIndex,
            urls: urls,
            parentImageViews: imageViewList)
        
        present(vc, animated: true, completion: nil)
    }
    
    func addUI(){
        headView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 360)
        contentTxt.frame = CGRect(x: 10, y: 10, width: screenWidth-20, height: 120)
        contentTxt.borderStyle=UITextBorderStyle.roundedRect
        
        img1.frame = CGRect(x: 10, y: contentTxt.frame.maxY+5, width: 60, height: 60)
        //添加图片点击事件
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        img1.addGestureRecognizer(singleTapGesture)
        img1.isUserInteractionEnabled = true
        
        img2.frame = CGRect(x: img1.frame.maxX+2, y: contentTxt.frame.maxY+5, width: 60, height: 60)
        img3.frame = CGRect(x: img2.frame.maxX+2, y: contentTxt.frame.maxY+5, width: 60, height: 60)
        img4.frame = CGRect(x: img3.frame.maxX+2, y: contentTxt.frame.maxY+5, width: 60, height: 60)
        img5.frame = CGRect(x: img4.frame.maxX+2, y: contentTxt.frame.maxY+5, width: 60, height: 60)
        imgDecLad.frame = CGRect(x: 10, y: img4.frame.maxY+5, width: screenWidth-20, height: 30)
        imgDecLad.text = "最多可以上传5张图片"
        qqTxt.frame = CGRect(x: 10, y: imgDecLad.frame.maxY+5, width: screenWidth-20, height: 40)
        qqTxt.placeholder = "请留下QQ号、邮箱或者手机号，方便答疑解惑"
        qqTxt.borderStyle=UITextBorderStyle.roundedRect
        commitBtn.frame = CGRect(x: 10, y: qqTxt.frame.maxY+5, width: screenWidth-20, height: 40)
        commitBtn.setTitle("提交", for: .normal)
        commitBtn.setTitleColor(UIColor.white, for: .normal)
        commitBtn.backgroundColor = YMGlobalTheme()
        commitBtn.addTarget(self, action: #selector(comitClick), for: .touchUpInside)
        myLad.frame = CGRect(x: 10, y: commitBtn.frame.maxY+5, width: screenWidth-20, height: 30)
        myLad.text = "我的反馈"
        
        headView.addSubview(contentTxt)
        headView.addSubview(img1)
        headView.addSubview(img2)
        headView.addSubview(img3)
        headView.addSubview(img4)
        headView.addSubview(img5)
        headView.addSubview(imgDecLad)
        headView.addSubview(qqTxt)
        headView.addSubview(commitBtn)
        headView.addSubview(myLad)
        
        tableView.tableHeaderView = headView
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight - 100)
            make.top.equalTo(navigationBar.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "HMFeedBackCell", bundle: nil), forCellReuseIdentifier: "CellID")
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        loadIdeas()
    }
    
    func loadIdeas(){
        WZNetworkTool.shareNetworkTool.loadIdeas(userAccnum: userAccnum!, token: ten!) { (objInfo) in
            self.ideas = objInfo.data!
            self.tableView.reloadData()
        }
    }
    
    @objc func comitClick(){
        if (contentTxt.text?.isEmpty)! {
            showTip(msg: "请输入反馈内容")
        }
        if (qqTxt.text?.isEmpty)!{
            showTip(msg: "请输入联系方式")
        }
        
        WZNetworkTool.shareNetworkTool.addIdeas(userAccnum: userAccnum!, token: ten!, content: contentTxt.text!, contact: qqTxt.text!, images: images) { (bojInfo) in
            return
        }
    }
    
    func showTip(msg: String){
        SwiftProgressHUD.showInfo(msg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SwiftProgressHUD.hideAllHUD()
        }
        return
    }
    
    @objc func imageViewClick(){
        popupView()
    }
    
    //底部弹窗
    
    func popupView(){
        
        var alert: UIAlertController!
        
        alert = UIAlertController(title: "提示", message: "添加照片", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cleanAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil)
        
        let photoAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default){ (action:UIAlertAction)in
            
            self.camera()
            
        }
        
        let choseAction = UIAlertAction(title: "从手机相册选择", style: UIAlertActionStyle.default){ (action:UIAlertAction)in
            
            self.photo()
            
        }
        
        
        
        alert.addAction(cleanAction)
        
        alert.addAction(photoAction)
        
        alert.addAction(choseAction)
        
        self.present(alert, animated: true, completion: nil)
        
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
        img2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    //调用照片方法
    
    
    
    func photo(){
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 5
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            //                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            //            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            //            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            //            print("Finish: \(assets)")
            //            for asset in assets {
            //                self.img2.image = self.PHAssetToUIImage(asset: asset)
            //            }
            self.images.removeAll()
            for ass in assets{
                self.images.append(self.PHAssetToUIImage(asset: ass))
            }
            let picCount = assets.count
            switch picCount {
            case 1:
                self.img2.image = self.PHAssetToUIImage(asset: assets[0])
            case 2:
                self.img2.image = self.PHAssetToUIImage(asset: assets[0])
                self.img3.image = self.PHAssetToUIImage(asset: assets[1])
            case 3:
                self.img2.image = self.PHAssetToUIImage(asset: assets[0])
                self.img3.image = self.PHAssetToUIImage(asset: assets[1])
                self.img4.image = self.PHAssetToUIImage(asset: assets[2])
            case 4:
                self.img2.image = self.PHAssetToUIImage(asset: assets[0])
                self.img3.image = self.PHAssetToUIImage(asset: assets[1])
                self.img4.image = self.PHAssetToUIImage(asset: assets[2])
                self.img5.image = self.PHAssetToUIImage(asset: assets[3])
            case 5:
                self.img2.image = self.PHAssetToUIImage(asset: assets[0])
                self.img3.image = self.PHAssetToUIImage(asset: assets[1])
                self.img4.image = self.PHAssetToUIImage(asset: assets[2])
                self.img5.image = self.PHAssetToUIImage(asset: assets[3])
                self.img1.image = self.PHAssetToUIImage(asset: assets[4])
            default:
                break
            }
        }, completion: nil)
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        // 1. 根据 indexPath 获取视图模型
    //        let vm = ideas[indexPath.row]
    //
    //        // 2. 返回计算好的行高
    //        return vm.rowHeight
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = ideas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? HMFeedBackCell
        
        // 2. 设置 cell
        cell?.viewModel = vm
        
        return cell!
    }
    var imageViews = [UIImageView]()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //点击浏览大图
        //        if ideas[indexPath.row].pictures.count<1 {
        //            return
        //        }
        //        for i in  0..<ideas[indexPath.row].pictures.count{
        //            guard let data = try? Data.init(contentsOf: URL.init(string: ideas[indexPath.row].pictures[i])!),let image = UIImage.init(data: data) else{
        //                continue
        //            }
        //
        //            let imageView = UIImageView()
        //            imageView.image = image
        //            imageView.isUserInteractionEnabled = true
        //            //            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tap(ges:)))
        //            //            imageView.addGestureRecognizer(tapGes)
        //            imageViews.append(imageView)
        //        }
        //        let vc = YHPhotoBrowserController.photoBrowser(selectedIndex: 0, urls: ideas[indexPath.row].pictures, parentImageViews: imageViews)
        //
        //        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - 将PHAsset对象转为UIImage对象
    func PHAssetToUIImage(asset: PHAsset) -> UIImage {
        var image = UIImage()
        
        // 新建一个默认类型的图像管理器imageManager
        let imageManager = PHImageManager.default()
        
        // 新建一个PHImageRequestOptions对象
        let imageRequestOption = PHImageRequestOptions()
        
        // PHImageRequestOptions是否有效
        imageRequestOption.isSynchronous = true
        
        // 缩略图的压缩模式设置为无
        imageRequestOption.resizeMode = .none
        
        // 缩略图的质量为高质量，不管加载时间花多少
        imageRequestOption.deliveryMode = .highQualityFormat
        
        
        
        // 按照PHImageRequestOptions指定的规则取出图片
        imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 60, height: 60), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
            (result, _) -> Void in
            image = result!
        })
        return image
    }
}
