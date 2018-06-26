//
//	MonitorTypeMonitorData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MonitorTypeMonitorData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var monitorId : String!
	var monitorName : String!
	var standardValue : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		monitorId = dictionary["monitorId"] as? String
		monitorName = dictionary["monitorName"] as? String
		standardValue = dictionary["standardValue"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if monitorId != nil{
			dictionary["monitorId"] = monitorId
		}
		if monitorName != nil{
			dictionary["monitorName"] = monitorName
		}
		if standardValue != nil{
			dictionary["standardValue"] = standardValue
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        monitorId = aDecoder.decodeObject(forKey: "monitorId") as? String
        monitorName = aDecoder.decodeObject(forKey: "monitorName") as? String
        standardValue = aDecoder.decodeObject(forKey: "standardValue") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if monitorId != nil{
			aCoder.encode(monitorId, forKey: "monitorId")
		}
		if monitorName != nil{
			aCoder.encode(monitorName, forKey: "monitorName")
		}
		if standardValue != nil{
			aCoder.encode(standardValue, forKey: "standardValue")
		}

	}

}
