//
//	LoginData.swift
//
//	Create by apple on 4/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var area : LoginArea!
	var user : LoginUser!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let areaData = dictionary["area"] as? NSDictionary{
			area = LoginArea(fromDictionary: areaData)
		}
		if let userData = dictionary["user"] as? NSDictionary{
			user = LoginUser(fromDictionary: userData)
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if area != nil{
			dictionary["area"] = area.toDictionary()
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        area = aDecoder.decodeObject(forKey: "area") as? LoginArea
        user = aDecoder.decodeObject(forKey: "user") as? LoginUser

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if area != nil{
            aCoder.encode(area, forKey: "area")
		}
		if user != nil{
            aCoder.encode(user, forKey: "user")
		}

	}

}
