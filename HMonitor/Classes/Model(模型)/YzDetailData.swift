//
//	YzDetailData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class YzDetailData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var companyAddress : String!
	var companyId : String!
	var companyName : String!
	var dxType : Int!
	var isEquipmentDx : Bool!
	var isEquipmentYc : Bool!
	var isOutletDx : Bool!
	var monitorData : [YzDetailMonitorData]!
	var monitorDataCount : Int!
	var monitorDataList : [YzDetailMonitorData]!
	var monitorId : String!
	var monitorName : String!
	var outletId : String!
	var outletName : String!
	var outletType : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		companyAddress = dictionary["companyAddress"] as? String
		companyId = dictionary["companyId"] as? String
		companyName = dictionary["companyName"] as? String
		dxType = dictionary["dxType"] as? Int
		isEquipmentDx = dictionary["isEquipmentDx"] as? Bool
		isEquipmentYc = dictionary["isEquipmentYc"] as? Bool
		isOutletDx = dictionary["isOutletDx"] as? Bool
		monitorData = [YzDetailMonitorData]()
		if let monitorDataArray = dictionary["monitorData"] as? [NSDictionary]{
			for dic in monitorDataArray{
				let value = YzDetailMonitorData(fromDictionary: dic)
				monitorData.append(value)
			}
		}
		monitorDataCount = dictionary["monitorDataCount"] as? Int
		monitorDataList = [YzDetailMonitorData]()
		if let monitorDataListArray = dictionary["monitorDataList"] as? [NSDictionary]{
			for dic in monitorDataListArray{
				let value = YzDetailMonitorData(fromDictionary: dic)
				monitorDataList.append(value)
			}
		}
		monitorId = dictionary["monitorId"] as? String
		monitorName = dictionary["monitorName"] as? String
		outletId = dictionary["outletId"] as? String
		outletName = dictionary["outletName"] as? String
		outletType = dictionary["outletType"] as? String
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
		if companyId != nil{
			dictionary["companyId"] = companyId
		}
		if companyName != nil{
			dictionary["companyName"] = companyName
		}
		if dxType != nil{
			dictionary["dxType"] = dxType
		}
		if isEquipmentDx != nil{
			dictionary["isEquipmentDx"] = isEquipmentDx
		}
		if isEquipmentYc != nil{
			dictionary["isEquipmentYc"] = isEquipmentYc
		}
		if isOutletDx != nil{
			dictionary["isOutletDx"] = isOutletDx
		}
		if monitorData != nil{
			var dictionaryElements = [NSDictionary]()
			for monitorDataElement in monitorData {
				dictionaryElements.append(monitorDataElement.toDictionary())
			}
			dictionary["monitorData"] = dictionaryElements
		}
		if monitorDataCount != nil{
			dictionary["monitorDataCount"] = monitorDataCount
		}
		if monitorDataList != nil{
			var dictionaryElements = [NSDictionary]()
			for monitorDataListElement in monitorDataList {
				dictionaryElements.append(monitorDataListElement.toDictionary())
			}
			dictionary["monitorDataList"] = dictionaryElements
		}
		if monitorId != nil{
			dictionary["monitorId"] = monitorId
		}
		if monitorName != nil{
			dictionary["monitorName"] = monitorName
		}
		if outletId != nil{
			dictionary["outletId"] = outletId
		}
		if outletName != nil{
			dictionary["outletName"] = outletName
		}
		if outletType != nil{
			dictionary["outletType"] = outletType
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
        companyId = aDecoder.decodeObject(forKey: "companyId") as? String
        companyName = aDecoder.decodeObject(forKey: "companyName") as? String
        dxType = aDecoder.decodeObject(forKey: "dxType") as? Int
        isEquipmentDx = aDecoder.decodeObject(forKey: "isEquipmentDx") as? Bool
        isEquipmentYc = aDecoder.decodeObject(forKey: "isEquipmentYc") as? Bool
        isOutletDx = aDecoder.decodeObject(forKey: "isOutletDx") as? Bool
        monitorData = aDecoder.decodeObject(forKey: "monitorData") as? [YzDetailMonitorData]
        monitorDataCount = aDecoder.decodeObject(forKey: "monitorDataCount") as? Int
        monitorDataList = aDecoder.decodeObject(forKey: "monitorDataList") as? [YzDetailMonitorData]
        monitorId = aDecoder.decodeObject(forKey: "monitorId") as? String
        monitorName = aDecoder.decodeObject(forKey: "monitorName") as? String
        outletId = aDecoder.decodeObject(forKey: "outletId") as? String
        outletName = aDecoder.decodeObject(forKey: "outletName") as? String
        outletType = aDecoder.decodeObject(forKey: "outletType") as? String

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
		if companyId != nil{
			aCoder.encode(companyId, forKey: "companyId")
		}
		if companyName != nil{
			aCoder.encode(companyName, forKey: "companyName")
		}
		if dxType != nil{
			aCoder.encode(dxType, forKey: "dxType")
		}
		if isEquipmentDx != nil{
			aCoder.encode(isEquipmentDx, forKey: "isEquipmentDx")
		}
		if isEquipmentYc != nil{
			aCoder.encode(isEquipmentYc, forKey: "isEquipmentYc")
		}
		if isOutletDx != nil{
			aCoder.encode(isOutletDx, forKey: "isOutletDx")
		}
		if monitorData != nil{
			aCoder.encode(monitorData, forKey: "monitorData")
		}
		if monitorDataCount != nil{
			aCoder.encode(monitorDataCount, forKey: "monitorDataCount")
		}
		if monitorDataList != nil{
			aCoder.encode(monitorDataList, forKey: "monitorDataList")
		}
		if monitorId != nil{
			aCoder.encode(monitorId, forKey: "monitorId")
		}
		if monitorName != nil{
			aCoder.encode(monitorName, forKey: "monitorName")
		}
		if outletId != nil{
			aCoder.encode(outletId, forKey: "outletId")
		}
		if outletName != nil{
			aCoder.encode(outletName, forKey: "outletName")
		}
		if outletType != nil{
			aCoder.encode(outletType, forKey: "outletType")
		}

	}

}
