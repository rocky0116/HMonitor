//
//	LogPkData.swift
//
//	Create by apple on 9/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LogPkData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var offTime : [String]!
	var pfkName : String!
	var precent : String!
	var runTime : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		offTime = dictionary["offTime"] as? [String]
		pfkName = dictionary["pfkName"] as? String
		precent = dictionary["precent"] as? String
		runTime = dictionary["runTime"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if offTime != nil{
			dictionary["offTime"] = offTime
		}
		if pfkName != nil{
			dictionary["pfkName"] = pfkName
		}
		if precent != nil{
			dictionary["precent"] = precent
		}
		if runTime != nil{
			dictionary["runTime"] = runTime
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        offTime = aDecoder.decodeObject(forKey: "offTime") as? [String]
        pfkName = aDecoder.decodeObject(forKey: "pfkName") as? String
        precent = aDecoder.decodeObject(forKey: "precent") as? String
        runTime = aDecoder.decodeObject(forKey: "runTime") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if offTime != nil{
			aCoder.encode(offTime, forKey: "offTime")
		}
		if pfkName != nil{
			aCoder.encode(pfkName, forKey: "pfkName")
		}
		if precent != nil{
			aCoder.encode(precent, forKey: "precent")
		}
		if runTime != nil{
			aCoder.encode(runTime, forKey: "runTime")
		}

	}

}
