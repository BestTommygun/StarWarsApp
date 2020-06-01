//
//  Species.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

public class Species : DataItem {
    
    //Returns a list of Species that can be used on the home page
    public static func getSpeciesFromData(withData data:[String:Any]) -> [Species] {
        var returnList: [Species] = []
        
        let species = data["results"] as? Array<AnyObject>
        if let safeSpecies = species {
            for item in safeSpecies {
                let tempSpecies: Species = Species()
                tempSpecies.name = item["name"] as? String
                tempSpecies.type = item["classification"] as? String
                tempSpecies.itemElements.append("height: \((item["average_height"] as? String)!)")
                tempSpecies.itemElements.append("lifespan: \((item["average_lifespan"] as? String)!)")
                tempSpecies.itemElements.append("designation: \((item["designation"] as? String)!)")
                tempSpecies.imageString = "species-image"
                returnList.append(tempSpecies)
            }
        }
        return returnList
    }
}
