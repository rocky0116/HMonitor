//
//	LoginUser.swift
//
//	Create by apple on 4/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginUser : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var areaCode : String!
	var enterpriseId : String!
	var password : String!
	var phone : String!
	var salt : String!
	var userAccnum : String!
	var userCode : String!
	var userId : String!
	var userName : String!
	var userState : AnyObject!
	var userType : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		areaCode = dictionary["areaCode"] as? String
		enterpriseId = dictionary["enterpriseId"] as? String
		password = dictionary["password"] as? String
		phone = dictionary["phone"] as? String
		salt = dictionary["salt"] as? String
		userAccnum = dictionary["userAccnum"] as? String
		userCode = dictionary["userCode"] as? String
		userId = dictionary["userId"] as? String
		userName = dictionary["userName"] as? String
		userState = dictionary["userState"] as? AnyObject
		userType = dictionary["userType"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if areaCode != nil{
			dictionary["areaCode"] = areaCode
		}
		if enterpriseId != nil{
			dictionary["enterpriseId"] = enterpriseId
		}
		if password != nil{
			dictionary["password"] = password
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if salt != nil{
			dictionary["salt"] = salt
		}
		if userAccnum != nil{
			dictionary["userAccnum"] = userAccnum
		}
		if userCode != nil{
			dictionary["userCode"] = userCode
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		if userName != nil{
			dictionary["userName"] = userName
		}
		if userState != nil{
			dictionary["userState"] = userState
		}
		if userType != nil{
			dictionary["userType"] = userType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        areaCode = aDecoder.decodeObject(forKey: "areaCode") as? String
        enterpriseId = aDecoder.decodeObject(forKey: "enterpriseId") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        salt = aDecoder.decodeObject(forKey: "salt") as? String
        userAccnum = aDecoder.decodeObject(forKey: "userAccnum") as? String
        userCode = aDecoder.decodeObject(forKey: "userCode") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        userName = aDecoder.decodeObject(forKey: "userName") as? String
        userState = aDecoder.decodeObject(forKey: "userState") as? AnyObject
        userType = aDecoder.decodeObject(forKey: "userType") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if areaCode != nil{
            aCoder.encode(areaCode, forKey: "areaCode")
		}
		if enterpriseId != nil{
            aCoder.encode(enterpriseId, forKey: "enterpriseId")
		}
		if password != nil{
            aCoder.encode(password, forKey: "password")
		}
		if phone != nil{
            aCoder.encode(phone, forKey: "phone")
		}
		if salt != nil{
            aCoder.encode(salt, forKey: "salt")
		}
		if userAccnum != nil{
			aCoder.encode(userAccnum, forKey: "userAccnum")
		}
		if userCode != nil{
			aCoder.encode(userCode, forKey: "userCode")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}
		if userName != nil{
			aCoder.encode(userName, forKey: "userName")
		}
		if userState != nil{
			aCoder.encode(userState, forKey: "userState")
		}
		if userType != nil{
			aCoder.encode(userType, forKey: "userType")
		}

	}

}
