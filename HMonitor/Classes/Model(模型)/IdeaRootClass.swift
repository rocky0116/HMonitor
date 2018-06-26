//
//	IdeaRootClass.swift
//
//	Create by apple on 10/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IdeaRootClass : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var data : [IdeaData]!
	var edition : String!
	var message : String!
	var status : Int!
	var token : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		data = [IdeaData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = IdeaData(fromDictionary: dic)
				data.append(value)
			}
		}
		edition = dictionary["edition"] as? String
		message = dictionary["message"] as? String
		status = dictionary["status"] as? Int
		token = dictionary["token"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if data != nil{
			var dictionaryElements = [NSDictionary]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if edition != nil{
			dictionary["edition"] = edition
		}
		if message != nil{
			dictionary["message"] = message
		}
		if status != nil{
			dictionary["status"] = status
		}
		if token != nil{
			dictionary["token"] = token
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        data = aDecoder.decodeObject(forKey: "data") as? [IdeaData]
        edition = aDecoder.decodeObject(forKey: "edition") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        token = aDecoder.decodeObject(forKey: "token") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if data != nil{
            aCoder.encode(data, forKey: "data")
		}
		if edition != nil{
			aCoder.encode(edition, forKey: "edition")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if token != nil{
			aCoder.encode(token, forKey: "token")
		}

	}

}
