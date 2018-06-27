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

class WBHomeViewController: WBBaseViewController,MAMapViewDelegate {

    lazy var mapview = MAMapView()
    lazy var switchImg = UIImageView(image: UIImage(named: "分类"))
    
    var animatedCarAnnotation: AnimatedAnnotation!
    var animatedTrainAnnotation: AnimatedAnnotation!
    
    var pkType = "1"
    var qyDatas : [HomeQyQyList] = []
    var qyInfoDatas : [HomeQyInfoCompanyData] = []
    
    var qyId : String?
    var popMenu:SwiftPopMenu!
    
    override func setupUI() {
        super.setupUI()
        setupNavTitle()
        addSegmented()
        
        addMap()
        
        mapview.delegate = self
        mapview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        getQyList()
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(toJumpQyYz(noti:)), name: NSNotification.Name(rawValue: GoUpQyYzListy), object: nil)
    }
    
    func addMap(){
        self.view.addSubview(mapview)
        mapview.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.bottom.equalToSuperview().offset(0)
            make.top.equalTo(segmented.snp.bottom).offset(10)
        }
        
        self.view.addSubview(switchImg)
        switchImg.snp.makeConstraints { (make) in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.top.equalTo(segmented.snp.bottom).offset(70)
            make.right.equalToSuperview().offset(-16)
        }
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(showType))
        switchImg.addGestureRecognizer(singleTap)
        switchImg.isUserInteractionEnabled = true
    }
    
    @objc func toJumpQyYz(noti: Notification){
        //进行跳转
        let outletId = noti.userInfo!["outletId"]!
        let vc = HMQyPkDetailController()
        vc.qyId = self.qyId!
        vc.pkId = outletId as? String
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapview.selectAnnotation(animatedTrainAnnotation, animated: true)
    }
    
    func addAnn() {
        for item in self.qyDatas{
            var trainImages = Array<UIImage>()
            if !item.ycType && !item.cpType && !item.dxType{
                trainImages.append(UIImage(named: "poi1")!)
            }else if item.ycType{
                trainImages.append(UIImage(named: "poi2")!)
            }else if item.cpType{
                trainImages.append(UIImage(named: "poi3")!)
            }else{
                trainImages.append(UIImage(named: "poi4")!)
            }
            
            animatedTrainAnnotation = AnimatedAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.qywd!, longitude: item.qyjd!))
            
            animatedTrainAnnotation.animatedImages = trainImages
            animatedTrainAnnotation.title = item.qyId!
            animatedTrainAnnotation.subtitle = "CustomAnnotationView"
            
            mapview.addAnnotation(animatedTrainAnnotation)
        }
        
    }
   
    
    @objc func showType() {
        print(switchImg.frame.maxX,segmented.frame.maxY)
        popMenu = SwiftPopMenu(frame:  CGRect(x: screenWidth-160, y: 200, width: 150, height: 250), arrowMargin: 12)
        
        popMenu.popData = [(icon:"电话",title:"所有企业"),
                           (icon:"电话",title:"正常企业"),
                           (icon:"电话",title:"超标企业"),
                           (icon:"电话",title:"异常企业"),
                           (icon:"电话",title:"掉线企业")]
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
//            print("block select \(index)")
        }
        popMenu.show()
    }
    
    override func segementDidchange(segmented: UISegmentedControl) {
        pkType = "\(segmented.selectedSegmentIndex+1)"
        mapview.removeAnnotations(mapview.annotations)
        getQyList()
    }
    
    //MARK: 企业列表-用于在地图上显示坐标
    func getQyList(){
        WZNetworkTool.shareNetworkTool.loadHomeQy(userAccnum: userAccnum!, token: ten!, acode: aCode!, pkType: pkType) { (objInfo) in
            self.qyDatas = objInfo.data.qyList!
            self.addAnn()
            
        }
    }
    
    //MARK: - 高德地图代理
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is AnimatedAnnotation {
            let animatedAnnotationIdentifier: String! = "AnimatedAnnotationIdentifier"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: animatedAnnotationIdentifier) as? AnimatedAnnotationView
            
            if annotationView == nil {
                annotationView = AnimatedAnnotationView(annotation: annotation, reuseIdentifier: animatedAnnotationIdentifier)
            }
            annotationView?.canShowCallout = false
            annotationView?.isDraggable = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView?.calloutOffset = CGPoint.init(x: 0, y: -18)
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        getQyInfo(qyId: view.annotation.title!)
        
    }
    
    //MARK: 展示企业信息
    func getQyInfo(qyId: String){
        WZNetworkTool.shareNetworkTool.loadHomeQyInfo(userAccnum: userAccnum!, token: ten!, qyId: qyId) { (objInfo) in
            self.qyId = objInfo.data.companyId!
            
            let qyview = QyYzView.sQyView()
            qyview.pkType = self.pkType
            qyview.showData(model: objInfo.data)
            self.view.addSubview(qyview)
        }
    }
}



// MARK: - 设置界面
extension WBHomeViewController {
    
    /// 设置导航栏标题
     func setupNavTitle() {
        
        let button = UIButton()
        button.setTitle(aCity!, for: [])
        button.setImage(UIImage(named: "定位"), for: [])
        button.setTitleColor(UIColor.darkGray, for: [])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        navItem.titleView = button
        
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
        
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "切换"), style: UIBarButtonItemStyle.init(rawValue: 0)!, target: self, action: #selector(switchQy))
    }
    
    //MARK: 跳转到城市区域列表
    @objc func clickTitleButton(btn: UIButton) {
        let vc = UINavigationController(rootViewController: HMCityController())
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: 切换到企业列表
    @objc func switchQy() {
        let vc = HMQyListController()
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }
}
