//
//	QyDataDataList.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class QyDataDataList : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var over : Int!
	var pkId : String!
	var pkName : String!
	var qyId : String!
	var qyName : String!
	var wrw : Double!
	var wrwcpbs : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		over = dictionary["over"] as? Int
		pkId = dictionary["pkId"] as? String
		pkName = dictionary["pkName"] as? String
		qyId = dictionary["qyId"] as? String
		qyName = dictionary["qyName"] as? String
		wrw = dictionary["wrw"] as? Double
		wrwcpbs = dictionary["wrwcpbs"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if over != nil{
			dictionary["over"] = over
		}
		if pkId != nil{
			dictionary["pkId"] = pkId
		}
		if pkName != nil{
			dictionary["pkName"] = pkName
		}
		if qyId != nil{
			dictionary["qyId"] = qyId
		}
		if qyName != nil{
			dictionary["qyName"] = qyName
		}
		if wrw != nil{
			dictionary["wrw"] = wrw
		}
		if wrwcpbs != nil{
			dictionary["wrwcpbs"] = wrwcpbs
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        over = aDecoder.decodeObject(forKey: "over") as? Int
        pkId = aDecoder.decodeObject(forKey: "pkId") as? String
        pkName = aDecoder.decodeObject(forKey: "pkName") as? String
        qyId = aDecoder.decodeObject(forKey: "qyId") as? String
        qyName = aDecoder.decodeObject(forKey: "qyName") as? String
        wrw = aDecoder.decodeObject(forKey: "wrw") as? Double
        wrwcpbs = aDecoder.decodeObject(forKey: "wrwcpbs") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if over != nil{
			aCoder.encode(over, forKey: "over")
		}
		if pkId != nil{
			aCoder.encode(pkId, forKey: "pkId")
		}
		if pkName != nil{
			aCoder.encode(pkName, forKey: "pkName")
		}
		if qyId != nil{
			aCoder.encode(qyId, forKey: "qyId")
		}
		if qyName != nil{
			aCoder.encode(qyName, forKey: "qyName")
		}
		if wrw != nil{
			aCoder.encode(wrw, forKey: "wrw")
		}
		if wrwcpbs != nil{
			aCoder.encode(wrwcpbs, forKey: "wrwcpbs")
		}

	}

}
