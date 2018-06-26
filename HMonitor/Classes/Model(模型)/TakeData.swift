//
//	TakeData.swift
//
//	Create by apple on 9/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TakeData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var jd : String!
	var pkxx : [TakePkxx]!
	var qyId : String!
	var qyName : String!
	var qyjc : String!
	var wd : String!
	var data : [TakeData]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		jd = dictionary["jd"] as? String
		pkxx = [TakePkxx]()
		if let pkxxArray = dictionary["pkxx"] as? [NSDictionary]{
			for dic in pkxxArray{
				let value = TakePkxx(fromDictionary: dic)
				pkxx.append(value)
			}
		}
		qyId = dictionary["qyId"] as? String
		qyName = dictionary["qyName"] as? String
		qyjc = dictionary["qyjc"] as? String
		wd = dictionary["wd"] as? String
		data = [TakeData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = TakeData(fromDictionary: dic)
				data.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if jd != nil{
			dictionary["jd"] = jd
		}
		if pkxx != nil{
			var dictionaryElements = [NSDictionary]()
			for pkxxElement in pkxx {
				dictionaryElements.append(pkxxElement.toDictionary())
			}
			dictionary["pkxx"] = dictionaryElements
		}
		if qyId != nil{
			dictionary["qyId"] = qyId
		}
		if qyName != nil{
			dictionary["qyName"] = qyName
		}
		if qyjc != nil{
			dictionary["qyjc"] = qyjc
		}
		if wd != nil{
			dictionary["wd"] = wd
		}
		if data != nil{
			var dictionaryElements = [NSDictionary]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        jd = aDecoder.decodeObject(forKey: "jd") as? String
        pkxx = aDecoder.decodeObject(forKey: "pkxx") as? [TakePkxx]
        qyId = aDecoder.decodeObject(forKey: "qyId") as? String
        qyName = aDecoder.decodeObject(forKey: "qyName") as? String
        qyjc = aDecoder.decodeObject(forKey: "qyjc") as? String
        wd = aDecoder.decodeObject(forKey: "wd") as? String
        data = aDecoder.decodeObject(forKey: "data") as? [TakeData]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if jd != nil{
			aCoder.encode(jd, forKey: "jd")
		}
		if pkxx != nil{
			aCoder.encode(pkxx, forKey: "pkxx")
		}
		if qyId != nil{
			aCoder.encode(qyId, forKey: "qyId")
		}
		if qyName != nil{
			aCoder.encode(qyName, forKey: "qyName")
		}
		if qyjc != nil{
			aCoder.encode(qyjc, forKey: "qyjc")
		}
		if wd != nil{
			aCoder.encode(wd, forKey: "wd")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}

	}

}
