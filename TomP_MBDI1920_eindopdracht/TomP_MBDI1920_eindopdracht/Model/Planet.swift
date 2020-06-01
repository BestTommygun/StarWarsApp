//
//  Planet.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 29/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

public class Planet : DataItem {
    
    //Returns a list of people that can be used on the home page
    public static func getPlanetsFromData(withData data:[String:Any]) -> [Planet] {
        var returnList: [Planet] = []
        
        let people = data["results"] as? Array<AnyObject>
        if let safePeople = people {
            for item in safePeople {
                let tempPlanet: Planet = Planet()
                tempPlanet.name = item["name"] as? String
                tempPlanet.type = "\((item["diameter"] as? String)!) km diameter"
                tempPlanet.itemElements.append((item["climate"] as? String)!)
                tempPlanet.itemElements.append("\((item["population"] as? String)!) inhabitants")
                tempPlanet.itemElements.append((item["terrain"] as? String)!)
                tempPlanet.itemElements.append("\((item["surface_water"] as? String)!) % surface water")
                tempPlanet.imageString = "planets-image"
                returnList.append(tempPlanet)
            }
        }
        return returnList
    }
    
}
