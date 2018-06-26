//
//	IdeaData.swift
//
//	Create by apple on 10/5/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IdeaData : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
    }
    

	var id : String!
	var contact : String!
	var content : String!
	var createDate : Int!
	var isDelete : String!
	var pictures : [String]!
	var submitTime : Int!
	var userId : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		id = dictionary["Id"] as? String
		contact = dictionary["contact"] as? String
		content = dictionary["content"] as? String
		createDate = dictionary["create_date"] as? Int
		isDelete = dictionary["is_delete"] as? String
		pictures = dictionary["pictures"] as? [String]
		submitTime = dictionary["submitTime"] as? Int
		userId = dictionary["user_id"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if id != nil{
			dictionary["Id"] = id
		}
		if contact != nil{
			dictionary["contact"] = contact
		}
		if content != nil{
			dictionary["content"] = content
		}
		if createDate != nil{
			dictionary["create_date"] = createDate
		}
		if isDelete != nil{
			dictionary["is_delete"] = isDelete
		}
		if pictures != nil{
			dictionary["pictures"] = pictures
		}
		if submitTime != nil{
			dictionary["submitTime"] = submitTime
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        id = aDecoder.decodeObject(forKey: "Id") as? String
        contact = aDecoder.decodeObject(forKey: "contact") as? String
        content = aDecoder.decodeObject(forKey: "content") as? String
        createDate = aDecoder.decodeObject(forKey: "create_date") as? Int
        isDelete = aDecoder.decodeObject(forKey: "is_delete") as? String
        pictures = aDecoder.decodeObject(forKey: "pictures") as? [String]
        submitTime = aDecoder.decodeObject(forKey: "submitTime") as? Int
        userId = aDecoder.decodeObject(forKey: "user_id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if contact != nil{
			aCoder.encode(contact, forKey: "contact")
		}
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}
		if createDate != nil{
			aCoder.encode(createDate, forKey: "create_date")
		}
		if isDelete != nil{
			aCoder.encode(isDelete, forKey: "is_delete")
		}
		if pictures != nil{
			aCoder.encode(pictures, forKey: "pictures")
		}
		if submitTime != nil{
			aCoder.encode(submitTime, forKey: "submitTime")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}
