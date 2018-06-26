//
//	TakePkxx.swift
//
//	Create by apple on 9/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TakePkxx : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var pkId : String!
	var pkName : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		pkId = dictionary["pkId"] as? String
		pkName = dictionary["pkName"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if pkId != nil{
			dictionary["pkId"] = pkId
		}
		if pkName != nil{
			dictionary["pkName"] = pkName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        pkId = aDecoder.decodeObject(forKey: "pkId") as? String
        pkName = aDecoder.decodeObject(forKey: "pkName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if pkId != nil{
			aCoder.encode(pkId, forKey: "pkId")
		}
		if pkName != nil{
			aCoder.encode(pkName, forKey: "pkName")
		}

	}

}
