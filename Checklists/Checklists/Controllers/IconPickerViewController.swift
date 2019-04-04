//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import Foundation
import UIKit

class IconPickerViewController : UITableViewController {
    var delegate: IconPickerViewControllerDelegate?
    var imageSelection = IconAsset.NoIcon
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            imageSelection = IconAsset.Appointments
        case 1:
            imageSelection = IconAsset.Birthdays
        case 2:
            imageSelection = IconAsset.Chores
        case 3:
            imageSelection = IconAsset.Drinks
        case 4:
            imageSelection = IconAsset.Folder
        case 5:
            imageSelection = IconAsset.Groceries
        case 6:
            imageSelection = IconAsset.Inbox
        case 7:
            imageSelection = IconAsset.NoIcon
        case 8:
            imageSelection = IconAsset.Photos
        case 9:
            imageSelection = IconAsset.Trips
        default:
            imageSelection = IconAsset.NoIcon
        }
        
        self.delegate?.iconPickerViewController(self, didFinishAddingItem: imageSelection)
    }
}


protocol IconPickerViewControllerDelegate : class {
    func iconPickerViewControllerDidCancel(_ controller: IconPickerViewController)
    func iconPickerViewController(_ controller: IconPickerViewController, didFinishAddingItem item: IconAsset)
    func listDetailViewController(_ controller: IconPickerViewController, didFinishEditingItem item: IconAsset)
}
