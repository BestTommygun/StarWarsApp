//
//  People.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

class Person : DataItem {
    
    //Returns a list of people that can be used on the home page
    public static func getPeopleFromData(withData data:[String:Any]) -> [Person] {
        var returnList: [Person] = []
        
        let people = data["results"] as? Array<AnyObject>
        if let safePeople = people {
            for item in safePeople {
                let tempPerson: Person = Person()
                tempPerson.name = item["name"] as? String
                tempPerson.type =  item["birth_year"] as? String
                tempPerson.itemElements.append("\((item["height"] as? String)!) cm")
                tempPerson.itemElements.append("\((item["mass"] as? String)!) kg")
                tempPerson.itemElements.append("\((item["hair_color"] as? String)!) hair")
                tempPerson.itemElements.append("\((item["eye_color"] as? String)!) eye colour")
                tempPerson.itemElements.append("\((item["skin_color"] as? String)!) skin colour")
                tempPerson.itemElements.append((item["gender"] as? String)!)
                
                tempPerson.imageString = "people-image"
                returnList.append(tempPerson)
            }
        }
        return returnList
    }
}
