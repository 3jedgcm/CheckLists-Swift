//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var itemList: [CheckListItem] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList.append(CheckListItem(text: "Cookie"))
        itemList.append(CheckListItem(text: "Mashmallow"))
        itemList.append(CheckListItem(text: "Candy"))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem)
    {
        if(item.checked)
        {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem)
    {
        cell.textLabel?.text = item.text
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        self.configureCheckmark(for:cell, withItem: itemList[indexPath.row])
        self.configureText(for:cell, withItem: itemList[indexPath.row])
        
        return cell
    }


}

