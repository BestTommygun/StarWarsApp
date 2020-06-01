//
//  DataItem.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

public class DataItem : NSObject, NSCoding {
    
    //MARK:- Properties
    public var name: String?
    public var type: String?
    public var imageString: String? = "placeholder-image"
    public var itemElements: [String] = []
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
    
    
    //MARK:- functions
    public override init(){
        
    }

    //MARK:- NSCoding
    struct PropertyKey {
        static let name = "name"
        static let type = "type"
        static let imageString = "imageString"
        static let itemElements = "elements"
        static let item = "item"
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(type, forKey: PropertyKey.type)
        aCoder.encode(imageString, forKey: PropertyKey.imageString)
        aCoder.encode(itemElements, forKey: PropertyKey.itemElements)
    }
    
    public required init(withName name: String, withType type: String, withImage imageString: String, withElements elements: [String]) {
        self.name = name
        self.type = type
        self.imageString = imageString
        self.itemElements = elements
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        guard let decodedName = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Something went wrong when decoding item name!")
            return nil
        }
        guard let decodedType = aDecoder.decodeObject(forKey: PropertyKey.type) as? String else {
            print("Something went wrong when decoding item type!")
            return nil
        }
        guard let decodedImageString = aDecoder.decodeObject(forKey: PropertyKey.imageString) as? String else {
            print("Something went wrong when decoding item imageString!")
            return nil
        }
        guard let decodedItemElements = aDecoder.decodeObject(forKey: PropertyKey.itemElements) as? [String] else {
            print("Something went wrong when decoding item elements!")
            return nil
        }
        self.init(withName: decodedName, withType: decodedType, withImage: decodedImageString, withElements: decodedItemElements)
    }
}
