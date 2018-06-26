//
//  WZNetworkTool.swift
//  hxlhEmep
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftProgressHUD

class WZNetworkTool: NSObject {
    /// 单例
    static let shareNetworkTool = WZNetworkTool()
    
    /// 登录
    func loadLogin(userAccnum: String,pwd: String, finished:@escaping (_ loginInfo: LoginRootClass) -> ()) {
        //        let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=20&offset=0"
        let url = BASE_URL + "user/userLandPass"
        let params = ["userAccnum": userAccnum,
                      "userpass": pwd]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                print(response.request)
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
               
                
                let userName = LoginRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                finished(userName)
                
        }
    }
    
    /// 获取区域数据
    func loadArea(userAccnum: String,token: String,areaCode : String, finished:@escaping (_ cityInfo: CityRootClass) -> ()) {
        let url = BASE_URL + "area/getAreas"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "areaCode": areaCode]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                let robj = CityRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取数据查询因子类型
    func loadDataYzType(userAccnum: String,token: String,type : String, finished:@escaping (_ yzObj: MonitorTypeRootClass) -> ()) {
        let url = BASE_URL + "monitor/getMonitorDetails"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "outletId": "",
                      "monitorType": "2",
                      "type": type]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = MonitorTypeRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取数据查询列表
    func loadDataList(userAccnum: String,token: String,areaCode : String,tableType : String,pkType : String, wrwId: String,testingType : String,multipleType:String,qyType:String,pageSize: String , page: String, finished:@escaping (_ qyDataObj: QyDataRootClass) -> ()) {
        let url = BASE_URL + "monitor/getDataList"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "areaCode": areaCode,
                      "tableType": tableType,
                      "pkType": pkType,
                      "wrwName": wrwId,
                      "testingType": testingType,
                      "multipleType": multipleType,
                      "qyType": qyType,
                      "pageSize" : pageSize,
                      "page" : page
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = QyDataRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                
                if robj.status == 0 {
                   finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
    
        }
    }
    
    /// 获取企业详情
    func loadQyDetail(userAccnum: String,token: String,companyId : String, finished:@escaping (_ qyDataObj: QyDetailRootClass) -> ()) {
        let url = BASE_URL + "company/getCompanyDetails"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "companyId": companyId
                      
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = QyDetailRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
        }
    }
    
    /// 获取排口详情
    func loadPkDetail(userAccnum: String,token: String,companyId : String,outletId : String, finished:@escaping (_ qyDataObj: PkDetailRootClass) -> ()) {
        let url = BASE_URL + "outlet/getOutletDetails"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "companyId": companyId,
                      "outletId": outletId
            
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = PkDetailRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
        }
    }
    
    /// 获取因子详情
    func loadYzDetail(userAccnum: String,token: String,companyId : String,outletId : String,monitorId: String,page : String,dataType: String,dateType:String, finished:@escaping (_ qyDataObj: YzDetailRootClass) -> ()) {
        let url = BASE_URL + "monitor/getMonitorDetailsData"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "monitorId": monitorId,
                      "rows": pageSize,
                      "page": page,
                      "dataType" : dataType,
                      "dateType" : dateType,
                      "companyId": companyId,
                      "outletId": outletId
            
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = YzDetailRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
        }
    }
    
    /// 获取统计因子类型
    func loadTjYzType(userAccnum: String,token: String,type : String, finished:@escaping (_ yzObj: MonitorTypeRootClass) -> ()) {
        let url = BASE_URL + "monitor/getMonitorDetails"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "outletId": "",
                      "monitorType": "1",
                      "type": type]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = MonitorTypeRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取统计因子类型
    func loadTjData(userAccnum: String,token: String,charType : String,startTime:String,endTime:String,acode:String,wrwName:String, finished:@escaping (_ yzObj: TjDataRootClass) -> ()) {
        let url = BASE_URL + "chart/getEmission"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "startTime": startTime,
                      "endTime": endTime,
                      "areaCode": acode,
                      "charType": charType,
                      "wrwName": wrwName]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = TjDataRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取统计因子类型
    func loadTjQyList(userAccnum: String,token: String,charType : String,startTime:String,endTime:String,acode:String,wrwName:String,num : String,type : String,code: String, finished:@escaping (_ yzObj: TjQyRootClass) -> ()) {
        let url = BASE_URL + "chart/getQyEmission"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "startTime": startTime,
                      "endTime": endTime,
                      "areaCode": acode,
                      "charType": charType,
                      "wrwName": wrwName,
                      "num": num,
                      "type" : type,
                      "code" : code]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = TjQyRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取执法取证
    func loadTake(userAccnum: String,token: String,acode : String, finished:@escaping (_ yzObj: TakeRootClass) -> ()) {
        let url = BASE_URL + "company/getQyxx"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "areaCode": acode
                      ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = TakeRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取预警日志
    func loadLog(userAccnum: String,token: String,acode : String,logType: String,queryTime:String, finished:@escaping (_ yzObj: LogRootClass) -> ()) {
        let url = BASE_URL + "alertlog/getAbnormal"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "areaCode": acode,
                      "logType" : logType,
                      "queryTime" : queryTime
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = LogRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取我的意见反馈列表
    func loadIdeas(userAccnum: String,token: String, finished:@escaping (_ yzObj: IdeaRootClass) -> ()) {
        let url = BASE_URL + "feedback/getFeedback"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = IdeaRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取首页企业列表
    func loadHomeQy(userAccnum: String,token: String,acode : String,pkType:String, finished:@escaping (_ yzObj: HomeQyRootClass) -> ()) {
        let url = BASE_URL + "company/getQyList"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "areaCode": acode,
                      "pkType" : pkType,
                      "qyName":""
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = HomeQyRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 获取首页企业信息
    func loadHomeQyInfo(userAccnum: String,token: String,qyId : String, finished:@escaping (_ yzObj: HomeQyInfoRootClass) -> ()) {
        let url = BASE_URL + "company/getCompanyDetails"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "companyId": qyId
        ]
        
        SwiftProgressHUD.showWait()
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SwiftProgressHUD.showFail("加载失败...")
                    return
                }
                print(response.request)
                
                let robj = HomeQyInfoRootClass(fromDictionary: response.result.value as! NSDictionary)
                SwiftProgressHUD.hideAllHUD()
                if robj.status == 0 {
                    finished(robj)
                }else{
                    let alert = UIAlertView(title: "温馨提示", message: robj.message, delegate: nil, cancelButtonTitle: "知道了")
                    alert.show()
                    return
                }
                
                
        }
    }
    
    /// 添加意见反馈
    func addIdeas(userAccnum: String,token: String,content: String,contact: String,images : [UIImage], finished:@escaping (_ yzObj: IdeaRootClass) -> ()) {
        let url = BASE_URL + "feedback/submitIdea"
        let params = ["userAccnum": userAccnum,
                      "token": token,
                      "edition": versionCode,
                      "content": content,
                      "contact" : contact
        ]
        
        SwiftProgressHUD.showWait()
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                // 压缩
                for image in images{
                    let data = UIImageJPEGRepresentation(image, 0.5)
                    let fileName = String.init(describing: NSDate()) + ".png"
                    multipartFormData.append(data!, withName: "myfiles", fileName: fileName, mimeType: "image/png")
                }
                
                
                //如果需要上传多个文件,就多添加几个
                //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //......
                for (key, value) in params{
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
        },to: url,encodingCompletion: { encodingResult in
            SwiftProgressHUD.hideAllHUD()
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                //打印连接失败原因
                print(encodingError)
            }
        })
        
        
        
    }
    /// 获取首页顶部选择数据
//    func loadHomeTopData(finished:@escaping (_ ym_channels: [YMChannel]) -> ()) {
//
//        let url = BASE_URL + "v2/channels/preset"
//        let params = ["gender": 1,
//                      "generation": 1]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    let data = dict["data"].dictionary
//                    if let channels = data!["channels"]?.arrayObject {
//                        var ym_channels = [YMChannel]()
//                        for channel in channels {
//                            let ym_channel = YMChannel(dict: channel as! [String: AnyObject])
//                            ym_channels.append(ym_channel)
//                        }
//                        finished(ym_channels)
//                    }
//                }
//        }
//    }
//
//    /// 搜索界面数据
//    func loadHotWords(finished:@escaping (_ words: [String]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v1/search/hot_words"
//        Alamofire
//            .request(url)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let hot_words = data["hot_words"]?.arrayObject {
//                            finished(hot_words as! [String])
//                        }
//                    }
//                }
//        }
//    }
//
//    /// 根据搜索条件进行搜索
//    func loadSearchResult(keyword: String, sort: String, finished:@escaping (_ results: [YMSearchResult]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = "http://api.dantangapp.com/v1/search/item"
//
//        let params = ["keyword": keyword,
//                      "limit": 20,
//                      "offset": 0,
//                      "sort": sort] as [String : Any]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    let data = dict["data"].dictionary
//                    if let items = data!["items"]?.arrayObject {
//                        var results = [YMSearchResult]()
//                        for item in items {
//                            let result = YMSearchResult(dict: item as! [String: AnyObject])
//                            results.append(result)
//                        }
//                        finished(results)
//                    }
//                }
//        }
//    }
//
//    /// 获取单品数据
//    func loadProductData(finished:@escaping (_ products: [YMProduct]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v2/items"
//        let params = ["gender": 1,
//                      "generation": 1,
//                      "limit": 20,
//                      "offset": 0]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let items = data["items"]?.arrayObject {
//                            var products = [YMProduct]()
//                            for item in items {
//                                let itemDict = item as! [String : AnyObject]
//                                if let itemData = itemDict["data"] {
//                                    let product = YMProduct(dict: itemData as! [String: AnyObject])
//                                    products.append(product)
//                                }
//                            }
//                            finished(products)
//                        }
//                    }
//                }
//        }
//    }
//
//    /// 获取单品详情数据
//    func loadProductDetailData(id: Int, finished:@escaping (_ productDetail: YMProductDetail) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v2/items/\(id)"
//        Alamofire
//            .request(url)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionaryObject {
//                        let productDetail = YMProductDetail(dict: data as [String : AnyObject])
//                        finished(productDetail)
//                    }
//                }
//        }
//    }
//
//    /// 商品详情 评论
//    func loadProductDetailComments(id: Int, finished:@escaping (_ comments: [YMComment]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v2/items/\(id)/comments"
//        let params = ["limit": 20,
//                      "offset": 0]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let commentsData = data["comments"]?.arrayObject {
//                            var comments = [YMComment]()
//                            for item in commentsData {
//                                let comment = YMComment(dict: item as! [String: AnyObject])
//                                comments.append(comment)
//                            }
//                            finished(comments)
//                        }
//                    }
//                }
//        }
//    }
//
//    /// 分类界面 顶部 专题合集
//    func loadCategoryCollection(limit: Int, finished:@escaping (_ collections: [YMCollection]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v1/collections"
//        let params = ["limit": limit,
//                      "offset": 0]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SwiftProgressHUD.showFail("加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.showInfo(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let collectionsData = data["collections"]?.arrayObject {
//                            var collections = [YMCollection]()
//                            for item in collectionsData {
//                                let collection = YMCollection(dict: item as! [String: AnyObject])
//                                collections.append(collection)
//                            }
//                            finished(collections)
//                        }
//                    }
//                }
//        }
//    }
//
//    /// 顶部 专题合集 -> 专题列表
//    func loadCollectionPosts(id: Int, finished:@escaping (_ posts: [YMCollectionPost]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v1/collections/\(id)/posts"
//        let params = ["gender": 1,
//                      "generation": 1,
//                      "limit": 20,
//                      "offset": 0]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SVProgressHUD.show(withStatus: "加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.show(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let postsData = data["posts"]?.arrayObject {
//                            var posts = [YMCollectionPost]()
//                            for item in postsData {
//                                let post = YMCollectionPost(dict: item as! [String: AnyObject])
//                                posts.append(post)
//                            }
//                            finished(posts)
//                        }
//                    }
//                }
//        }
//    }
//
//    /// 分类界面 风格,品类
//    func loadCategoryGroup(finished:@escaping (_ outGroups: [AnyObject]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v1/channel_groups/all"
//        Alamofire
//            .request(url)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SVProgressHUD.show(withStatus: "加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.show(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let channel_groups = data["channel_groups"]?.arrayObject {
//                            // outGroups 存储两个 inGroups 数组，inGroups 存储 YMGroup 对象
//                            // outGroups 是一个二维数组
//                            var outGroups = [AnyObject]()
//                            for channel_group in channel_groups {
//                                var inGroups = [YMGroup]()
//                                let channel_group_dict = channel_group as! [String: AnyObject]
//                                let channels = channel_group_dict["channels"] as! [AnyObject]
//                                for channel in channels {
//                                    let group = YMGroup(dict: channel as! [String: AnyObject])
//                                    inGroups.append(group)
//                                }
//                                outGroups.append(inGroups as AnyObject)
//                            }
//                            finished(outGroups)
//                        }
//                    }
//                }
//        }
//    }
//
//    /// 底部 风格品类 -> 列表
//    func loadStylesOrCategoryInfo(id: Int, finished:@escaping (_ items: [YMCollectionPost]) -> ()) {
//        SVProgressHUD.show(withStatus: "正在加载...")
//        let url = BASE_URL + "v1/channels/\(id)/items"
//        let params = ["limit": 20,
//                      "offset": 0]
//        Alamofire
//            .request(url, parameters: params)
//            .responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    SVProgressHUD.show(withStatus: "加载失败...")
//                    return
//                }
//                if let value = response.result.value {
//                    let dict = JSON(value)
//                    let code = dict["code"].intValue
//                    let message = dict["message"].stringValue
//                    guard code == RETURN_OK else {
//                        SVProgressHUD.show(withStatus: message)
//                        return
//                    }
//                    SwiftProgressHUD.hideAllHUD()
//                    if let data = dict["data"].dictionary {
//                        if let itemsData = data["items"]?.arrayObject {
//                            var items = [YMCollectionPost]()
//                            for item in itemsData {
//                                let post = YMCollectionPost(dict: item as! [String: AnyObject])
//                                items.append(post)
//                            }
//                            finished(items)
//                        }
//                    }
//                }
//        }
//    }
    
}
