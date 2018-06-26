//
//	QyDetailCompanyData.swift
//
//	Create by apple on 7/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class QyDetailCompanyData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
	var dxType : Int!
	var isEquipmentDx : Bool!
	var isEquipmentYc : Bool!
	var isOutletCp : Bool!
	var isOutletDx : Bool!
	var isOutletYc : Bool!
	var outletId : String!
	var outletName : String!
	var outletType : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		dxType = dictionary["dxType"] as? Int
		isEquipmentDx = dictionary["isEquipmentDx"] as? Bool
		isEquipmentYc = dictionary["isEquipmentYc"] as? Bool
		isOutletCp = dictionary["isOutletCp"] as? Bool
		isOutletDx = dictionary["isOutletDx"] as? Bool
		isOutletYc = dictionary["isOutletYc"] as? Bool
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
		if dxType != nil{
			dictionary["dxType"] = dxType
		}
		if isEquipmentDx != nil{
			dictionary["isEquipmentDx"] = isEquipmentDx
		}
		if isEquipmentYc != nil{
			dictionary["isEquipmentYc"] = isEquipmentYc
		}
		if isOutletCp != nil{
			dictionary["isOutletCp"] = isOutletCp
		}
		if isOutletDx != nil{
			dictionary["isOutletDx"] = isOutletDx
		}
		if isOutletYc != nil{
			dictionary["isOutletYc"] = isOutletYc
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
        dxType = aDecoder.decodeObject(forKey: "dxType") as? Int
        isEquipmentDx = aDecoder.decodeObject(forKey: "isEquipmentDx") as? Bool
        isEquipmentYc = aDecoder.decodeObject(forKey: "isEquipmentYc") as? Bool
        isOutletCp = aDecoder.decodeObject(forKey: "isOutletCp") as? Bool
        isOutletDx = aDecoder.decodeObject(forKey: "isOutletDx") as? Bool
        isOutletYc = aDecoder.decodeObject(forKey: "isOutletYc") as? Bool
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
		if dxType != nil{
            aCoder.encode(dxType, forKey: "dxType")
		}
		if isEquipmentDx != nil{
            aCoder.encode(isEquipmentDx, forKey: "isEquipmentDx")
		}
		if isEquipmentYc != nil{
            aCoder.encode(isEquipmentYc, forKey: "isEquipmentYc")
		}
		if isOutletCp != nil{
            aCoder.encode(isOutletCp, forKey: "isOutletCp")
		}
		if isOutletDx != nil{
            aCoder.encode(isOutletDx, forKey: "isOutletDx")
		}
		if isOutletYc != nil{
            aCoder.encode(isOutletYc, forKey: "isOutletYc")
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
