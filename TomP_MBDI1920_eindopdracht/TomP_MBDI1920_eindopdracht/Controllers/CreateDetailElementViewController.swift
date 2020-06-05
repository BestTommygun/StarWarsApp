//
//  CreateDetailElementViewController.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 05/06/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class CreateDetailElementViewController : UITableViewController {
    //MARK:- Properties
    public var itemElements: [String] = []
    
    //MARK:- Function
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let safeCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? DetailViewControllerCell else {
            fatalError("the dequeued cell is not an instance of DetailviewControllerCell")
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
        return 50
    }
}
