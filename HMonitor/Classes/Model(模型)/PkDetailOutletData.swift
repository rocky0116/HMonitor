//
//	PkDetailOutletData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PkDetailOutletData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var dayData : String!
	var hourData : String!
	var monitorId : String!
	var monitorName : String!
	var realtime : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		dayData = dictionary["dayData"] as? String
		hourData = dictionary["hourData"] as? String
		monitorId = dictionary["monitorId"] as? String
		monitorName = dictionary["monitorName"] as? String
		realtime = dictionary["realtime"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if dayData != nil{
			dictionary["dayData"] = dayData
		}
		if hourData != nil{
			dictionary["hourData"] = hourData
		}
		if monitorId != nil{
			dictionary["monitorId"] = monitorId
		}
		if monitorName != nil{
			dictionary["monitorName"] = monitorName
		}
		if realtime != nil{
			dictionary["realtime"] = realtime
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        dayData = aDecoder.decodeObject(forKey: "dayData") as? String
        hourData = aDecoder.decodeObject(forKey: "hourData") as? String
        monitorId = aDecoder.decodeObject(forKey: "monitorId") as? String
        monitorName = aDecoder.decodeObject(forKey: "monitorName") as? String
        realtime = aDecoder.decodeObject(forKey: "realtime") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if dayData != nil{
			aCoder.encode(dayData, forKey: "dayData")
		}
		if hourData != nil{
			aCoder.encode(hourData, forKey: "hourData")
		}
		if monitorId != nil{
			aCoder.encode(monitorId, forKey: "monitorId")
		}
		if monitorName != nil{
			aCoder.encode(monitorName, forKey: "monitorName")
		}
		if realtime != nil{
			aCoder.encode(realtime, forKey: "realtime")
		}

	}

}
