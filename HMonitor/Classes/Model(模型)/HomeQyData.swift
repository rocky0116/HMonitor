//
//	HomeQyData.swift
//
//	Create by apple on 16/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HomeQyData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var qyList : [HomeQyQyList]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		qyList = [HomeQyQyList]()
		if let qyListArray = dictionary["qyList"] as? [NSDictionary]{
			for dic in qyListArray{
				let value = HomeQyQyList(fromDictionary: dic)
				qyList.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if qyList != nil{
			var dictionaryElements = [NSDictionary]()
			for qyListElement in qyList {
				dictionaryElements.append(qyListElement.toDictionary())
			}
			dictionary["qyList"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        qyList = aDecoder.decodeObject(forKey: "qyList") as? [HomeQyQyList]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if qyList != nil{
            aCoder.encode(qyList, forKey: "qyList")
		}

	}

}
