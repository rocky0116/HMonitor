//
//  HMNetworkManager.swift
//  HMonitor
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 hxlh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftProgressHUD

enum HMHTTPMethod {
    case GET
    case POST
}

class HMNetworkManager: NSObject {
    
    static let shared = HMNetworkManager()
    var baseUrl:String = ""
    /// 是否拼接token令牌
    var isNeedAccessToken:Bool = true
    /// 公共参数
    var baseParams:NSMutableDictionary = [:]
    
    
    /// 用户账户的懒加载属性
    lazy var userAccount = WBUserAccount()
    /// 用户登录标记[计算型属性]
    var userLogon: Bool {
        return userAccount.access_token != nil
    }
    
    private override init() {
        
    }
    
    
    //MARK: 拼接完整的url
    func getCompleteUlr(url: String) ->String{
        let newUlr = self.baseUrl.appending(url)
        if self.isNeedAccessToken {
            // 拼接token
        }
        return newUlr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    //MARK: 凭借完整的参数
    func combinationParams(params:NSDictionary) -> NSDictionary{
        self.baseParams.addEntries(from: params as! [AnyHashable : Any])
        return self.baseParams
    }
    
    //MARK: 获取请求方式
    func getHttpMethod(method: HMHTTPMethod) -> HTTPMethod{
        if method == .POST {
            return .post
        }else {
            return .get
        }
    }
    
    
    /// 专门负责拼接 token 的网络请求方法
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter name:       上传文件使用的字段名，默认为 nil，不上传文件
    /// - parameter data:       上传文件的二进制数据，默认为 nil，不上传文件
    /// - parameter completion: 完成回调
    func tokenRequest(method: HMHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, name: String? = nil, data: Data? = nil, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool)->()) {
        
        // 处理 token 字典
        // 0> 判断 token 是否为 nil，为 nil 直接返回，程序执行过程中，一般 token 不会为 nil
        guard let token = userAccount.access_token else {
            
            // 发送通知，提示用户登录
            print("没有 token! 需要登录")
            
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),
                object: nil)
            
            completion(nil, false)
            
            return
        }
        
        // 1> 判断 参数字典是否存在，如果为 nil，应该新建一个字典
        var parameters = parameters
        if parameters == nil {
            // 实例化字典
            parameters = [String: AnyObject]()
        }
        
        // 2> 设置参数字典，代码在此处字典一定有值
        parameters!["access_token"] = token as AnyObject
        
        // 3> 判断 name 和 data
        if let name = name, let data = data {
            // 上传文件
            upload(URLString: URLString, parameters: parameters, name: name, data: data, completion: completion)
        } else {
            request(method: method, URLString: URLString, parameters: parameters, completion: completion)
        }
    }
    
    // MARK: - 封装 上传文件 方法
    
    func upload(URLString: String, parameters: [String: AnyObject]?, name: String, data: Data, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool)->()) {
 
        
    }
    
    // MARK: -封装 Alamofire 的 GET / POST 请求
    func request(method: HMHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool)->()) {
        
        let headers: HTTPHeaders = [
            "Accept" : "application/json",
            //                "Accept" : "text/javascript",
            //                "Accept" : "text/html",
            //                "Accept" : "text/plain"
        ]
        ///验证证书
        self.verificationCertificate()
        
        //进行请求
        SwiftProgressHUD.showWait()
        Alamofire.request(URLString, method: self.getHttpMethod(method: method), parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print("地址：\(response.request)")
            SwiftProgressHUD.hideAllHUD()
            guard response.result.isSuccess else {
                if response.response?.statusCode == 403 {
                    print("Token 过期了")
                    // 发送通知，提示用户再次登录(本方法不知道被谁调用，谁接收到通知，谁处理！)
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),
                        object: "bad token")
                }else{
                    SwiftProgressHUD.showFail("服务错误，请稍后再试...")
                }
                completion(nil, false)
                return
            }
            
            //请求成功处理,回调
            
            let dic: NSDictionary = response.result.value as! NSDictionary
            let status:NSNumber = dic.object(forKey: "status") as! NSNumber
            if status.isEqual(to: NSNumber.init(value: 0)){
                //返回错误码，错误信息
                let message: String = dic.object(forKey: "message") as! String
                SwiftProgressHUD.showFail(message)
            }else{
                //                //base64解码
                //                let decodedData = NSData.init(base64Encoded: dic.object(forKey: "result") as! String, options: NSData.Base64DecodingOptions.init(rawValue: 0))
                //                let decodedString:NSString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)!
                //                //解析json字符串
                //                let data:Data = decodedString.data(using: String.Encoding.utf8.rawValue)!
                //                let resultDic = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                //
                
                
                completion(response.result.value as AnyObject, true)
            }
            
            
        }
        
        
    }
    
    //MARK: https证书验证
    func verificationCertificate() -> Void {
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var dispositon : URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                dispositon = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    
                    dispositon = .cancelAuthenticationChallenge
                    
                } else {
                    credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    
                    if credential != nil {
                        dispositon = .useCredential
                    }
                }
            }
            
            return (dispositon,credential)
            
        }
    }
}
