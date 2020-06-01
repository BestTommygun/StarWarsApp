//
//  SWAPIHelper.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 28/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

class SWAPIHelper {
    static let instance = SWAPIHelper()
    
    private init() {
    }
    
    public func getData(disabledCategories: [String]) -> [DataItem] {
        var dataItems: [DataItem] = []
        let group = DispatchGroup()
        
        if(!disabledCategories.contains("films")) {
            group.enter()
            DispatchQueue.global(qos: .utility).async {
                self.getFilms() {data in
                    //sleep(5000) //use this to show that it is async
                    dataItems.append(contentsOf: data)
                    print("TASK films is done")
                    group.leave()

                }
            }
        }
        if(!disabledCategories.contains("people")) {
            group.enter()
            DispatchQueue.global(qos: .utility).async {
                self.getPeople() {data in
                    //sleep(5000) //use this to show that it is async
                    dataItems.append(contentsOf: data)
                    print("TASK people is done")
                    group.leave()

                }
            }
        }
        if(!disabledCategories.contains("species")) {
            group.enter()
            DispatchQueue.global(qos: .utility).async {
                self.getSpecies() {data in
                    //sleep(5000) //use this to show that it is async
                    dataItems.append(contentsOf: data)
                    print("TASK species is done")
                    group.leave()

                }
            }
        }
        if(!disabledCategories.contains("vehicles")) {
            group.enter()
            DispatchQueue.global(qos: .utility).async {
               self.getVehicles() {data in
                    //sleep(5000) //use this to show that it is async
                    dataItems.append(contentsOf: data)
                    print("TASK vehicles is done")
                    group.leave()

                }
            }
        }
        if(!disabledCategories.contains("starships")) {
            group.enter()
            DispatchQueue.global(qos: .utility).async {
                self.getStarships() {data in
                    //sleep(5000) //use this to show that it is async
                    dataItems.append(contentsOf: data)
                    print("TASK starships is done")
                    group.leave()

                }
            }
        }
        if(!disabledCategories.contains("planets")) {
            group.enter()
            DispatchQueue.global(qos: .utility).async {
                self.getPlanets() {data in
                    //sleep(5000) //use this to show that it is async
                    dataItems.append(contentsOf: data)
                    print("TASK planets is done")
                    group.leave()

                }
            }
        }
        group.wait()
        return dataItems
    }
    
    //MARK:- get categories requests
    public func getFilms(callback: @escaping ([Film]) -> Void) -> Void {
        var films: [Film] = []
        get(url: "films", params: ""){data in
            if let safeData = data {
                films.append(contentsOf: Film.getFilmsFromData(withData: safeData))
                callback(films)
            }
        }
    }
    
    public func getPeople(callback: @escaping ([Person]) -> Void) -> Void {
        var people: [Person] = []
        get(url: "people", params: ""){data in
            if let safeData = data {
                people.append(contentsOf: Person.getPeopleFromData(withData: safeData))
                callback(people)
            }
        }
    }
    
    public func getSpecies(callback: @escaping ([Species]) -> Void) -> Void {
        var species: [Species] = []
        get(url: "species", params: ""){data in
            if let safeData = data {
                species.append(contentsOf: Species.getSpeciesFromData(withData: safeData))
                callback(species)
            }
        }
    }
    
    public func getVehicles(callback: @escaping ([Vehicle]) -> Void) -> Void {
        var vehicles: [Vehicle] = []
        get(url: "vehicles", params: ""){data in
            if let safeData = data {
                vehicles.append(contentsOf: Vehicle.getVehiclesFromData(withData: safeData))
                callback(vehicles)
            }
        }
    }
    
    public func getStarships(callback: @escaping ([Starship]) -> Void) -> Void {
        var starships: [Starship] = []
        get(url: "starships", params: ""){data in
            if let safeData = data {
                starships.append(contentsOf: Starship.getStarshipsFromData(withData: safeData))
                callback(starships)
            }
        }
    }
    
    public func getPlanets(callback: @escaping ([Planet]) -> Void) -> Void {
        var planets: [Planet] = []
        get(url: "planets", params: ""){data in
            if let safeData = data {
                planets.append(contentsOf: Planet.getPlanetsFromData(withData: safeData))
                callback(planets)
            }
        }
    }
    
    //MARK:- Base Request
    private func get(url: String, params: String, callback: @escaping ([String: Any]?) -> Void) {
        let apiURL = URL(string: "https://swapi.dev/api/\(url)/\(params)")
        guard let safeURL = apiURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: safeURL) {
            data, response, error in
            do {
                if let safeData = data {
                    let json = try JSONSerialization.jsonObject(with: safeData) as! [String: Any]
                    callback(json)
                }
                else {
                    callback(nil)
                }
            } catch {
                print("Something went wrong when getting data...")
                print("error:")
                //print(error)
            }
        }
        task.resume()
    }
}
