//
//  AddItemViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    var delegate: ListDetailViewControllerDelegate?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var itemLabel: UITextField!
    
    var itemToEdit: Checklist!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil)
        {
            itemLabel.text = itemToEdit.name
        }
    }
    
    @IBAction func done(_ sender: Any) {
        if(itemToEdit != nil)
        {
            itemToEdit.name = itemLabel.text!
            self.delegate?.listDetailViewController(self, didFinishEditingItem: itemToEdit)
        } else
        {
            self.delegate?.listDetailViewController(self, didFinishAddingItem: Checklist(list: [], name: itemLabel.text!, icon: IconAsset.Birthdays))
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.listDetailViewControllerDidCancel(self)
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

protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist)
}
