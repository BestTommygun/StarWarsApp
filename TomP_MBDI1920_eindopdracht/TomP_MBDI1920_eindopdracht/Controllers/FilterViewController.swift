//
//  FilterViewController.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 29/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//
import Foundation
import UIKit

class FilterViewController : UIViewController {
    @IBOutlet private var peopleSwitch: UISwitch!
    @IBOutlet private var planetSwitch: UISwitch!
    @IBOutlet private var filmSwitch: UISwitch!
    @IBOutlet private var speciesSwitch: UISwitch!
    @IBOutlet private var starshipSwitch: UISwitch!
    @IBOutlet private var vehicleSwitch: UISwitch!
    
    private var hasBeenLoaded = false
    private var disabledCategories: [String] = []
    struct Categories {
        static let films = "films"
        static let people = "people"
        static let species = "species"
        static let vehicles = "vehicles"
        static let starships = "starships"
        static let planets = "planets"
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hasBeenLoaded = true
        setSliders()
    }
    
    public func setDisabledCategories(disabledCategories: [String]) {
        self.disabledCategories = disabledCategories
    }
    
    public func setSliders() {
        peopleSwitch.setOn(!self.disabledCategories.contains(Categories.people), animated: false)
        planetSwitch.setOn(!self.disabledCategories.contains(Categories.planets), animated: false)
        filmSwitch.setOn(!self.disabledCategories.contains(Categories.films), animated: false)
        speciesSwitch.setOn(!self.disabledCategories.contains(Categories.species), animated: false)
        starshipSwitch.setOn(!self.disabledCategories.contains(Categories.starships), animated: false)
        vehicleSwitch.setOn(!self.disabledCategories.contains(Categories.vehicles), animated: false)
    }
    
    public func getDisabledCategories() -> [String] {
        if !hasBeenLoaded {
            return []
        }
        self.disabledCategories = [];
        if !peopleSwitch.isOn {
            self.disabledCategories.append(Categories.people)
        }
        if !planetSwitch.isOn {
            self.disabledCategories.append(Categories.planets)
        }
        if !filmSwitch.isOn {
            self.disabledCategories.append(Categories.films)
        }
        if !speciesSwitch.isOn {
            self.disabledCategories.append(Categories.species)
        }
        if !starshipSwitch.isOn {
            self.disabledCategories.append(Categories.starships)
        }
        if !vehicleSwitch.isOn {
            self.disabledCategories.append(Categories.vehicles)
        }
        return self.disabledCategories
    }
    
    public func getFilteredItems(withItems items: [DataItem]) -> [DataItem]{
        if !hasBeenLoaded {
            return items
        }
        
        var returnItems: [DataItem] = []
        
        if peopleSwitch.isOn {
            returnItems.append(contentsOf: items.filter { $0 is Person })
        }
        if planetSwitch.isOn {
            returnItems.append(contentsOf: items.filter { $0 is Planet })
        }
        if filmSwitch.isOn {
            returnItems.append(contentsOf: items.filter { $0 is Film })
        }
        if speciesSwitch.isOn {
            returnItems.append(contentsOf: items.filter { $0 is Species })
        }
        if starshipSwitch.isOn {
            returnItems.append(contentsOf: items.filter { $0 is Starship })
        }
        if vehicleSwitch.isOn {
            returnItems.append(contentsOf: items.filter { $0 is Vehicle })
        }
        return returnItems
    }
}
