//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    


     var list: Checklist!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         if(segue.identifier == "addItem") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.delegate = self
            destVC.doneButton.isEnabled = false
        } else if(segue.identifier == "editItem") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.delegate = self
            destVC.doneButton.isEnabled = true
            let indexPathOfSelectedCell = self.tableView.indexPath(for: (sender  as! ChecklistItemCell))
            destVC.itemToEdit = list.list[indexPathOfSelectedCell!.row]
        }
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem)
    {
        if(item.checked)
        {
            (cell as! ChecklistItemCell).checkNameLabel.isHidden = false
        }
        else
        {
            (cell as! ChecklistItemCell).checkNameLabel.isHidden = true
        }
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem)
    {
        (cell as! ChecklistItemCell).textNameLabel.text = item.text
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.list.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.list.list[indexPath.row].toggleChecked()
        tableView.reloadRows(at:[indexPath],with: UITableView.RowAnimation.automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        self.configureCheckmark(for:cell, withItem: list.list[indexPath.row])
        self.configureText(for:cell, withItem: list.list[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.list.remove(at:indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    

}

extension ChecklistViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        let indexOfEditedItem = list.list.index(where:{ $0 === item })
        tableView.reloadRows(at:[IndexPath(row: indexOfEditedItem!, section: 0)],with: UITableView.RowAnimation.automatic)
        dismiss(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        list.list.insert(item, at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        dismiss(animated: true)
    }
}
