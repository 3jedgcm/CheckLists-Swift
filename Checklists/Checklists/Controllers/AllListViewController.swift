//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class AllListViewController : UITableViewController
{

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        DataSingleton.sharedInstance.load()
        DataSingleton.sharedInstance.itemList.append(Checklist(list:[ChecklistItem(text: "Jambon")],name:"Vharcuterie",icon:IconAsset.Trips))
        DataSingleton.sharedInstance.itemList.append(Checklist(list:[ChecklistItem(text: "Jambon")],name:"Aharcuterie",icon:IconAsset.Chores))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "inEnter")
        {
            let destVC = segue.destination as! ChecklistViewController
            let indexPathOfSelectedCell = self.tableView.indexPath(for: (sender  as! UITableViewCell))
            destVC.list = DataSingleton.sharedInstance.itemList[indexPathOfSelectedCell!.row]
        }
        else if(segue.identifier == "add")
        {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ListDetailViewController
            destVC.delegate = self
            destVC.doneButton.isEnabled = false
        }
        else if(segue.identifier == "edit")
        {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ListDetailViewController
            destVC.delegate = self
            destVC.doneButton.isEnabled = true
            let indexPathOfSelectedCell = self.tableView.indexPath(for: (sender as! UITableViewCell))
            destVC.itemToEdit = DataSingleton.sharedInstance.itemList[indexPathOfSelectedCell!.row]
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkList", for: indexPath)
        DataSingleton.sharedInstance.sortChecklists()
        cell.imageView?.image = DataSingleton.sharedInstance.itemList[indexPath.row].icon.image
        cell.textLabel?.text = DataSingleton.sharedInstance.itemList[indexPath.row].name
        cell.detailTextLabel?.text = DataSingleton.sharedInstance.itemList[indexPath.row].uncheckedItemsCount
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataSingleton.sharedInstance.itemList.remove(at:indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return DataSingleton.sharedInstance.itemList.count;
    }
    
}

extension AllListViewController: ListDetailViewControllerDelegate {

    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist) {
        let indexOfEditedItem = DataSingleton.sharedInstance.itemList.index(where:{ $0 === item })
        tableView.reloadRows(at:[IndexPath(row: indexOfEditedItem!, section: 0)],with: UITableView.RowAnimation.automatic)
        dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist) {

        DataSingleton.sharedInstance.itemList.insert(item, at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        dismiss(animated: true)
    }
}
