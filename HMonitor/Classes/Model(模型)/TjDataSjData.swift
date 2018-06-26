//
//	TjDataSjData.swift
//
//	Create by apple on 8/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TjDataSjData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var code : String!
	var name : String!
	var num : String!
	var value : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		name = dictionary["name"] as? String
		num = dictionary["num"] as? String
		value = dictionary["value"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if code != nil{
			dictionary["code"] = code
		}
		if name != nil{
			dictionary["name"] = name
		}
		if num != nil{
			dictionary["num"] = num
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        code = aDecoder.decodeObject(forKey: "code") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        num = aDecoder.decodeObject(forKey: "num") as? String
        value = aDecoder.decodeObject(forKey: "value") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if code != nil{
            aCoder.encode(code, forKey: "code")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if num != nil{
			aCoder.encode(num, forKey: "num")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}
