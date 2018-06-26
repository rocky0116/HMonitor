//
//	TjQyData.swift
//
//	Create by apple on 8/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TjQyData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var name : String!
	var zdtype : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		name = dictionary["name"] as? String
		zdtype = dictionary["zdtype"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if name != nil{
			dictionary["name"] = name
		}
		if zdtype != nil{
			dictionary["zdtype"] = zdtype
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        name = aDecoder.decodeObject(forKey: "name") as? String
        zdtype = aDecoder.decodeObject(forKey: "zdtype") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if name != nil{
            aCoder.encode(name, forKey: "name")
		}
		if zdtype != nil{
            aCoder.encode(zdtype, forKey: "zdtype")
		}

	}

}
