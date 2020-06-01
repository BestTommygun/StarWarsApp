//
//  DetailElementsUITableViewController.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 28/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//
import Foundation
import UIKit

public class DetailViewController : UITableViewController {
    public var itemElements: [String] = []
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    //MARK:- tableview functions
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let safeCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailViewControllerCell else {
            fatalError("the dequeued cell is not an instance of DetailTableViewCell")
        }
        safeCell.elementTypeLabel.text = itemElements[indexPath.row]
        return safeCell
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemElements.count
    }
    
    override public func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
