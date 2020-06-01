//
//  Films.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

public class Film : DataItem {
    
    //Returns a list of Films that can be used on the home page
    public static func getFilmsFromData(withData data:[String:Any]) -> [Film] {
        var returnList: [Film] = []
        
        let films = data["results"] as? Array<AnyObject>
        if let safeFilms = films {
            for item in safeFilms {
                let tempFilm: Film = Film()
                tempFilm.name = item["title"] as? String
                tempFilm.type = item["director"] as? String
                tempFilm.itemElements.append("producer(s) :\((item["producer"] as? String)!)")
                tempFilm.itemElements.append("released: \((item["release_date"] as? String)!)")
                tempFilm.imageString = "films-image"
                returnList.append(tempFilm)
            }
        }
        return returnList
    }
    
}
