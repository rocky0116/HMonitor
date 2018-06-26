//
//	TjDataData.swift
//
//	Create by apple on 8/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TjDataData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var sjData : [TjDataSjData]!
	var type : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		sjData = [TjDataSjData]()
		if let sjDataArray = dictionary["sjData"] as? [NSDictionary]{
			for dic in sjDataArray{
				let value = TjDataSjData(fromDictionary: dic)
				sjData.append(value)
			}
		}
		type = dictionary["type"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if sjData != nil{
			var dictionaryElements = [NSDictionary]()
			for sjDataElement in sjData {
				dictionaryElements.append(sjDataElement.toDictionary())
			}
			dictionary["sjData"] = dictionaryElements
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        sjData = aDecoder.decodeObject(forKey: "sjData") as? [TjDataSjData]
        type = aDecoder.decodeObject(forKey: "type") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if sjData != nil{
			aCoder.encode(sjData, forKey: "sjData")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}
