//
//	YzDetailMonitorData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class YzDetailMonitorData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var dateTime : String!
	var over : String!
	var value : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		dateTime = dictionary["dateTime"] as? String
		over = dictionary["over"] as? String
		value = dictionary["value"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if dateTime != nil{
			dictionary["dateTime"] = dateTime
		}
		if over != nil{
			dictionary["over"] = over
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
        dateTime = aDecoder.decodeObject(forKey: "dateTime") as? String
        over = aDecoder.decodeObject(forKey: "over") as? String
        value = aDecoder.decodeObject(forKey: "value") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if dateTime != nil{
			aCoder.encode(dateTime, forKey: "dateTime")
		}
		if over != nil{
			aCoder.encode(over, forKey: "over")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}
