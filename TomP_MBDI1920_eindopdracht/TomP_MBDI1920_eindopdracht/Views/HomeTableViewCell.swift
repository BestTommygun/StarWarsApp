//
//  HomeTableViewCell.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 19/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//
import Foundation
import UIKit

class HomeTableViewCell : UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var headerImageView: UIImageView!
    
    public func setItem(withItem item: DataItem) {
        self.nameLabel.text = item.name
        self.typeLabel.text = item.type
        self.headerImageView.image = UIImage(named: item.imageString!)
    }
}
