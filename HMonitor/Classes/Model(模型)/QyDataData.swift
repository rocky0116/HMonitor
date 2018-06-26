//
//	QyDataData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class QyDataData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var dataCount : Int!
	var dataList : [QyDataDataList]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		dataCount = dictionary["dataCount"] as? Int
		dataList = [QyDataDataList]()
		if let dataListArray = dictionary["dataList"] as? [NSDictionary]{
			for dic in dataListArray{
				let value = QyDataDataList(fromDictionary: dic)
				dataList.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if dataCount != nil{
			dictionary["dataCount"] = dataCount
		}
		if dataList != nil{
			var dictionaryElements = [NSDictionary]()
			for dataListElement in dataList {
				dictionaryElements.append(dataListElement.toDictionary())
			}
			dictionary["dataList"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        dataCount = aDecoder.decodeObject(forKey: "dataCount") as? Int
        dataList = aDecoder.decodeObject(forKey: "dataList") as? [QyDataDataList]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if dataCount != nil{
			aCoder.encode(dataCount, forKey: "dataCount")
		}
		if dataList != nil{
			aCoder.encode(dataList, forKey: "dataList")
		}

	}

}
