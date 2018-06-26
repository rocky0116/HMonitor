//
//	LoginArea.swift
//
//	Create by apple on 4/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginArea : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var areaCode : String!
	var areaName : String!
	var fistChar : String!
	var jd : String!
	var wd : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		areaCode = dictionary["areaCode"] as? String
		areaName = dictionary["areaName"] as? String
		fistChar = dictionary["fistChar"] as? String
		jd = dictionary["jd"] as? String
		wd = dictionary["wd"] as? String
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
		if areaName != nil{
			dictionary["areaName"] = areaName
		}
		if fistChar != nil{
			dictionary["fistChar"] = fistChar
		}
		if jd != nil{
			dictionary["jd"] = jd
		}
		if wd != nil{
			dictionary["wd"] = wd
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
        areaName = aDecoder.decodeObject(forKey: "areaName") as? String
        fistChar = aDecoder.decodeObject(forKey: "fistChar") as? String
        jd = aDecoder.decodeObject(forKey: "jd") as? String
        wd = aDecoder.decodeObject(forKey: "wd") as? String

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
		if areaName != nil{
            aCoder.encode(areaName, forKey: "areaName")
		}
		if fistChar != nil{
            aCoder.encode(fistChar, forKey: "fistChar")
		}
		if jd != nil{
            aCoder.encode(jd, forKey: "jd")
		}
		if wd != nil{
            aCoder.encode(wd, forKey: "wd")
		}

	}

}
