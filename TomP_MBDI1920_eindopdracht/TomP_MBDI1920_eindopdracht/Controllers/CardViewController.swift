//
//  DetailViewController.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 22/05/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

public class CardViewController : UIViewController {
    @IBOutlet private var elementImage: UIImageView!
    @IBOutlet private var elementTitle: UILabel!
    @IBOutlet private var elementSubTitle: UILabel!
    public var item: DataItem?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildDetailsPage()
    }
    
    public func buildDetailsPage() {
        if let safeItem = item {
            elementImage.image = UIImage(named: safeItem.imageString ?? "")
            elementTitle.text = safeItem.name
            elementSubTitle.text = safeItem.type
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let elementsVC = segue.destination as? DetailViewController {
            elementsVC.itemElements = item?.itemElements ?? []
        }
    }
}
