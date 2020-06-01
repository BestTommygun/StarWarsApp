//
//  Starships.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

public class Starship : DataItem {
    
    //Returns a list of Starships that can be used on the home page
    public static func getStarshipsFromData(withData data:[String:Any]) -> [Starship] {
        var returnList: [Starship] = []
        
        let starShips = data["results"] as? Array<AnyObject>
        if let safeStarships = starShips {
            for item in safeStarships {
                let tempStarship: Starship = Starship()
                tempStarship.name = item["name"] as? String
                tempStarship.type = item["model"] as? String
                tempStarship.itemElements.append("cost: \((item["cost_in_credits"] as? String) ?? "unknown amount of") credits")
                tempStarship.itemElements.append("crew amount: \((item["crew"] as? String) ?? "unknown")")
                tempStarship.itemElements.append("passengers: \((item["passengers"] as? String) ?? "unknown")")
                tempStarship.itemElements.append("length: \((item["length"] as? String) ?? "unknown amount of") m")
                tempStarship.imageString = "starships-image"
                returnList.append(tempStarship)
            }
        }
        return returnList
    }
}
