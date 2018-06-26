//
//	CityData.swift
//
//	Create by apple on 4/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CityData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var senArea : [AnyObject]!
	var shiArea : [AnyObject]!
	var xianArea : [CityXianArea]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		senArea = dictionary["senArea"] as? [AnyObject]
		shiArea = dictionary["shiArea"] as? [AnyObject]
		xianArea = [CityXianArea]()
		if let xianAreaArray = dictionary["xianArea"] as? [NSDictionary]{
			for dic in xianAreaArray{
				let value = CityXianArea(fromDictionary: dic)
				xianArea.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if senArea != nil{
			dictionary["senArea"] = senArea
		}
		if shiArea != nil{
			dictionary["shiArea"] = shiArea
		}
		if xianArea != nil{
			var dictionaryElements = [NSDictionary]()
			for xianAreaElement in xianArea {
				dictionaryElements.append(xianAreaElement.toDictionary())
			}
			dictionary["xianArea"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        senArea = aDecoder.decodeObject(forKey: "senArea") as? [AnyObject]
        shiArea = aDecoder.decodeObject(forKey: "shiArea") as? [AnyObject]
        xianArea = aDecoder.decodeObject(forKey: "xianArea") as? [CityXianArea]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if senArea != nil{
			aCoder.encode(senArea, forKey: "senArea")
		}
		if shiArea != nil{
			aCoder.encode(shiArea, forKey: "shiArea")
		}
		if xianArea != nil{
			aCoder.encode(xianArea, forKey: "xianArea")
		}

	}

}
