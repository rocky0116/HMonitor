//
//	HomeQyInfoData.swift
//
//	Create by apple on 22/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HomeQyInfoData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var companyAddress : String!
	var companyData : [HomeQyInfoCompanyData]!
	var companyId : String!
	var companyName : String!
	var envName : String!
	var envPhone : String!
	var pqNum : Int!
	var psNum : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		companyAddress = dictionary["companyAddress"] as? String
		companyData = [HomeQyInfoCompanyData]()
		if let companyDataArray = dictionary["companyData"] as? [NSDictionary]{
			for dic in companyDataArray{
				let value = HomeQyInfoCompanyData(fromDictionary: dic)
				companyData.append(value)
			}
		}
		companyId = dictionary["companyId"] as? String
		companyName = dictionary["companyName"] as? String
		envName = dictionary["envName"] as? String
		envPhone = dictionary["envPhone"] as? String
		pqNum = dictionary["pqNum"] as? Int
		psNum = dictionary["psNum"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if companyAddress != nil{
			dictionary["companyAddress"] = companyAddress
		}
		if companyData != nil{
			var dictionaryElements = [NSDictionary]()
			for companyDataElement in companyData {
				dictionaryElements.append(companyDataElement.toDictionary())
			}
			dictionary["companyData"] = dictionaryElements
		}
		if companyId != nil{
			dictionary["companyId"] = companyId
		}
		if companyName != nil{
			dictionary["companyName"] = companyName
		}
		if envName != nil{
			dictionary["envName"] = envName
		}
		if envPhone != nil{
			dictionary["envPhone"] = envPhone
		}
		if pqNum != nil{
			dictionary["pqNum"] = pqNum
		}
		if psNum != nil{
			dictionary["psNum"] = psNum
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        companyAddress = aDecoder.decodeObject(forKey: "companyAddress") as? String
        companyData = aDecoder.decodeObject(forKey: "companyData") as? [HomeQyInfoCompanyData]
        companyId = aDecoder.decodeObject(forKey: "companyId") as? String
        companyName = aDecoder.decodeObject(forKey: "companyName") as? String
        envName = aDecoder.decodeObject(forKey: "envName") as? String
        envPhone = aDecoder.decodeObject(forKey: "envPhone") as? String
        pqNum = aDecoder.decodeObject(forKey: "pqNum") as? Int
        psNum = aDecoder.decodeObject(forKey: "psNum") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if companyAddress != nil{
			aCoder.encode(companyAddress, forKey: "companyAddress")
		}
		if companyData != nil{
			aCoder.encode(companyData, forKey: "companyData")
		}
		if companyId != nil{
			aCoder.encode(companyId, forKey: "companyId")
		}
		if companyName != nil{
			aCoder.encode(companyName, forKey: "companyName")
		}
		if envName != nil{
			aCoder.encode(envName, forKey: "envName")
		}
		if envPhone != nil{
			aCoder.encode(envPhone, forKey: "envPhone")
		}
		if pqNum != nil{
			aCoder.encode(pqNum, forKey: "pqNum")
		}
		if psNum != nil{
			aCoder.encode(psNum, forKey: "psNum")
		}

	}

}
