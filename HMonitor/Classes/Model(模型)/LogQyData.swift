//
//	LogQyData.swift
//
//	Create by apple on 9/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LogQyData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var pkData : [LogPkData]!
	var qyName : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		pkData = [LogPkData]()
		if let pkDataArray = dictionary["pkData"] as? [NSDictionary]{
			for dic in pkDataArray{
				let value = LogPkData(fromDictionary: dic)
				pkData.append(value)
			}
		}
		qyName = dictionary["qyName"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if pkData != nil{
			var dictionaryElements = [NSDictionary]()
			for pkDataElement in pkData {
				dictionaryElements.append(pkDataElement.toDictionary())
			}
			dictionary["pkData"] = dictionaryElements
		}
		if qyName != nil{
			dictionary["qyName"] = qyName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        pkData = aDecoder.decodeObject(forKey: "pkData") as? [LogPkData]
        qyName = aDecoder.decodeObject(forKey: "qyName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if pkData != nil{
			aCoder.encode(pkData, forKey: "pkData")
		}
		if qyName != nil{
			aCoder.encode(qyName, forKey: "qyName")
		}

	}

}
