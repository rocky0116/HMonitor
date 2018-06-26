//
//	LogData.swift
//
//	Create by apple on 9/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LogData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var qyData : [LogQyData]!
	var time : String!
	var timeType : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		qyData = [LogQyData]()
		if let qyDataArray = dictionary["qyData"] as? [NSDictionary]{
			for dic in qyDataArray{
				let value = LogQyData(fromDictionary: dic)
				qyData.append(value)
			}
		}
		time = dictionary["time"] as? String
		timeType = dictionary["timeType"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if qyData != nil{
			var dictionaryElements = [NSDictionary]()
			for qyDataElement in qyData {
				dictionaryElements.append(qyDataElement.toDictionary())
			}
			dictionary["qyData"] = dictionaryElements
		}
		if time != nil{
			dictionary["time"] = time
		}
		if timeType != nil{
			dictionary["timeType"] = timeType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        qyData = aDecoder.decodeObject(forKey: "qyData") as? [LogQyData]
        time = aDecoder.decodeObject(forKey: "time") as? String
        timeType = aDecoder.decodeObject(forKey: "timeType") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if qyData != nil{
            aCoder.encode(qyData, forKey: "qyData")
		}
		if time != nil{
			aCoder.encode(time, forKey: "time")
		}
		if timeType != nil{
			aCoder.encode(timeType, forKey: "timeType")
		}

	}

}
