//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    

    var itemList: [ChecklistItem] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList.append(ChecklistItem(text: "Cookie"))
        itemList.append(ChecklistItem(text: "Mashmallow"))
        itemList.append(ChecklistItem(text: "Candy"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItem") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! AddItemViewController
            destVC.delegate = self
        }
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem)
    {
        if(item.checked)
        {
            checkLabel.isHidden = false
            //cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else
        {
            checkLabel.isHidden = true
            //cell.accessoryType = UITableViewCell.AccessoryType.none
        }
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem)
    {
        //cell.textLabel?.text = item.text
        nameLabel.text = item.text
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemList.count;	
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemList[indexPath.row].toggleChecked()
        tableView.reloadRows(at:[indexPath],with: UITableView.RowAnimation.automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        itemList.insert(ChecklistItem(text: "Bonbon"), at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        self.configureCheckmark(for:cell, withItem: itemList[indexPath.row])
        self.configureText(for:cell, withItem: itemList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        itemList.remove(at:indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    



}

extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        itemList.insert(item, at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        dismiss(animated: true)
    }
}
