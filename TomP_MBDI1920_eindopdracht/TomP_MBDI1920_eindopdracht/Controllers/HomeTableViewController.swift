//
//  HomeTableView.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewController : UITableViewController {
    //MARK:- properties
    private var items: [DataItem] = []
    private var detailVC: DetailViewController?
    private var filterVC: FilterViewController = FilterViewController()
    private var createVC: CreateItemViewController?
    
    //MARK:- controller override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let safeCreateVC = createVC {
            if safeCreateVC.itemSaved {
                self.addItem(withItem: safeCreateVC.itemToCreate)
                self.tableView.reloadData()
                createVC?.itemSaved = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //get local data
        self.items = self.filterVC.getFilteredItems(withItems: self.loadSavedItems() ?? self.items)
        self.tableView.reloadData()
        
        //replace with online data if possible
        let disabledCategories = self.filterVC.getDisabledCategories()//call this here so the UI does not get checked outside the main thread
        //get non-local data if possible
        DispatchQueue.global(qos: .utility).async {
            let newItems = self.items
            self.items = SWAPIHelper.instance.getData(disabledCategories: disabledCategories)
            for item in newItems {
                if(!self.items.contains(item)) {
                    self.items.append(item)
                }
            }
            //needs to be a seperate thread since UI updates cannot be instantiated by the utility thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //detects what segue is happening and makes sure the according controller is correctly set
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            self.detailVC = detailVC
        }
        if let filterVC = segue.destination as? FilterViewController {
            filterVC.setDisabledCategories(disabledCategories: filterVC.getDisabledCategories())
            self.filterVC = filterVC
        }
        if let createVC = segue.destination as? CreateItemViewController {
            self.createVC = createVC
        }
    }
    
    //MARK:- table override functions
    //set cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for:
            indexPath) as? HomeTableViewCell else {
            fatalError("the dequeued cell is not an instance of HomeTableViewCell")
        }
        cell.setItem(withItem: items[indexPath.row])
        return cell
    }
    //number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //number of sections of table
    override func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    //select row listener
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailVC?.itemElements.append(items[indexPath.row].name ?? "")
        detailVC?.itemElements.append(items[indexPath.row].type ?? "")
        detailVC?.itemElements.append(contentsOf: items[indexPath.row].itemElements)
    }
    //MARK:- local data functions
    private func addItem(withItem item: DataItem) {
        items.append(item)
        items.append(contentsOf: items)
        self.tableView.reloadData()
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: DataItem.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Something went wrong when saving item...")
        }
        else {
            print("Item" + (item.name ?? "") + "succesfully saved")
        }
    }
    @IBAction func saveAllData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: DataItem.ArchiveURL.path)
        if isSuccessfulSave {
            print("saved all " + String(items.count) + " items to local")
        }
        if !isSuccessfulSave {
            print("items could not succesfully be saved")
        }
    }
    private func loadSavedItems() -> [DataItem]? {
        print("getting data from local")
        return NSKeyedUnarchiver.unarchiveObject(withFile: DataItem.ArchiveURL.path) as? [DataItem]
    }
}
