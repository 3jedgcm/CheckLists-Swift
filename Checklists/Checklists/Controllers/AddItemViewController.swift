//
//  AddItemViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var itemLabel: UITextField!
    var itemToEdit: ChecklistItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil)
        {
            itemLabel.text = itemToEdit.text
        }
    }
    
    @IBAction func done(_ sender: Any) {
        if(itemToEdit != nil)
        {
             itemToEdit.text = itemLabel.text!
             self.delegate?.addItemViewController(self, didFinishEditingItem: itemToEdit)
        } else
        {
          self.delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text: itemLabel.text!))
        }
     
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.addItemViewControllerDidCancel(self)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if(!newString!.isEmpty) {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
        return true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        itemLabel.becomeFirstResponder()
    }
}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller:AddItemViewController, didFinishEditingItem item:ChecklistItem)
}
