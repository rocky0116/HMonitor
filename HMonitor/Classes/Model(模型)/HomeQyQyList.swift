//
//	HomeQyQyList.swift
//
//	Create by apple on 16/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HomeQyQyList : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var cpType : Bool!
	var dxType : Bool!
	var qyId : String!
	var qyName : String!
	var qyNum : Int!
	var qyjd : Double!
	var qywd : Double!
	var ycType : Bool!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cpType = dictionary["cpType"] as? Bool
		dxType = dictionary["dxType"] as? Bool
		qyId = dictionary["qyId"] as? String
		qyName = dictionary["qyName"] as? String
		qyNum = dictionary["qyNum"] as? Int
		qyjd = dictionary["qyjd"] as? Double
		qywd = dictionary["qywd"] as? Double
		ycType = dictionary["ycType"] as? Bool
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if cpType != nil{
			dictionary["cpType"] = cpType
		}
		if dxType != nil{
			dictionary["dxType"] = dxType
		}
		if qyId != nil{
			dictionary["qyId"] = qyId
		}
		if qyName != nil{
			dictionary["qyName"] = qyName
		}
		if qyNum != nil{
			dictionary["qyNum"] = qyNum
		}
		if qyjd != nil{
			dictionary["qyjd"] = qyjd
		}
		if qywd != nil{
			dictionary["qywd"] = qywd
		}
		if ycType != nil{
			dictionary["ycType"] = ycType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        cpType = aDecoder.decodeObject(forKey: "cpType") as? Bool
        dxType = aDecoder.decodeObject(forKey: "dxType") as? Bool
        qyId = aDecoder.decodeObject(forKey: "qyId") as? String
        qyName = aDecoder.decodeObject(forKey: "qyName") as? String
        qyNum = aDecoder.decodeObject(forKey: "qyNum") as? Int
        qyjd = aDecoder.decodeObject(forKey: "qyjd") as? Double
        qywd = aDecoder.decodeObject(forKey: "qywd") as? Double
        ycType = aDecoder.decodeObject(forKey: "ycType") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if cpType != nil{
			aCoder.encode(cpType, forKey: "cpType")
		}
		if dxType != nil{
			aCoder.encode(dxType, forKey: "dxType")
		}
		if qyId != nil{
			aCoder.encode(qyId, forKey: "qyId")
		}
		if qyName != nil{
			aCoder.encode(qyName, forKey: "qyName")
		}
		if qyNum != nil{
			aCoder.encode(qyNum, forKey: "qyNum")
		}
		if qyjd != nil{
			aCoder.encode(qyjd, forKey: "qyjd")
		}
		if qywd != nil{
			aCoder.encode(qywd, forKey: "qywd")
		}
		if ycType != nil{
			aCoder.encode(ycType, forKey: "ycType")
		}

	}

}
