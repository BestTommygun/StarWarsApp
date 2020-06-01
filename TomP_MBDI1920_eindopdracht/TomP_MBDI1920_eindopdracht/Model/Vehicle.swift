//
//  Vechicles.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

public class Vehicle : DataItem {
    
    //Returns a list of Vehicles that can be used on the home page
    public static func getVehiclesFromData(withData data:[String:Any]) -> [Vehicle] {
        var returnList: [Vehicle] = []
        
        let vehicles = data["results"] as? Array<AnyObject>
        if let safeVehicles = vehicles {
            for item in safeVehicles {
                let tempVehicle: Vehicle = Vehicle()
                tempVehicle.name = item["name"] as? String
                tempVehicle.type = item["vehicle_class"] as? String
                tempVehicle.imageString = "vehicles-image"
                tempVehicle.itemElements.append("Model: \((item["model"] as? String) ?? "unknown")")
                tempVehicle.itemElements.append("cost: \((item["cost_in_credits"] as? String) ?? "unknown amount of") credits")
                tempVehicle.itemElements.append("crew amount: \((item["crew"] as? String) ?? "unknown")")
                tempVehicle.itemElements.append("passengers: \((item["passengers"] as? String) ?? "unknown")")
                tempVehicle.itemElements.append("length: \((item["length"] as? String) ?? "unknown amount of") m")
                returnList.append(tempVehicle)
            }
        }
        return returnList
    }
}
