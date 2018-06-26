//
//	MonitorTypeData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MonitorTypeData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var monitorData : [MonitorTypeMonitorData]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		monitorData = [MonitorTypeMonitorData]()
		if let monitorDataArray = dictionary["monitorData"] as? [NSDictionary]{
			for dic in monitorDataArray{
				let value = MonitorTypeMonitorData(fromDictionary: dic)
				monitorData.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if monitorData != nil{
			var dictionaryElements = [NSDictionary]()
			for monitorDataElement in monitorData {
				dictionaryElements.append(monitorDataElement.toDictionary())
			}
			dictionary["monitorData"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        monitorData = aDecoder.decodeObject(forKey: "monitorData") as? [MonitorTypeMonitorData]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if monitorData != nil{
			aCoder.encode(monitorData, forKey: "monitorData")
		}

	}

}
