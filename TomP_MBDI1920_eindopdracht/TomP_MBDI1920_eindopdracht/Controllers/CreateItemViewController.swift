//
//  CreateItemViewController.swift
//  TomP_MBDI1920_eindopdracht
//
//  Created by Max on 05/06/2020.
//  Copyright © 2020 Max. All rights reserved.
//
import Foundation
import UIKit

class CreateItemViewController : UIViewController {
     var itemToCreate: DataItem = DataItem()
     private var elementsVC: CreateDetailElementViewController?
     var itemSaved = false
     
     @IBOutlet var titleField: UITextField!
     @IBOutlet var subtitleField: UITextField!
     @IBOutlet var elementField: UITextField!
     
     @IBAction func saveAction(_ sender: UIButton) {
         createItem()
     }
     
     @IBAction func addElementAction(_ sender: UIButton) {
         createElement()
     }
     
     public override func viewDidLoad(){
         super.viewDidLoad()
        //add a tap gesture to close the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
     }
     
    
     private func createElement(){
         if let safeText = elementField.text {
             itemToCreate.itemElements.append(safeText)
             elementsVC?.itemElements = itemToCreate.itemElements
             elementsVC?.tableView.reloadData()
         }
     }
     
     private func createItem(){
         itemToCreate.name = titleField.text
         itemToCreate.type = subtitleField.text
         itemSaved = true
         navigationController?.popViewController(animated: true)
     }
     
     public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let elementVC = segue.destination as? CreateDetailElementViewController {
          self.elementsVC = elementVC
         }
     }
}
