//
//  ChecklistItem.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import Foundation

class ChecklistItem: Codable  {
    var text = "";
    var checked = false;
    var itemId = 0;
    var shouldRemind = false;
    var dueDate = Date();
    
    init(text:String)
    {
        self.text = text;
    }
    
    init(text:String, checked:Bool)
    {
        self.text = text;
        self.checked = checked;
    }
    
    init(text:String, checked:Bool, shouldRemind: Bool, dueDate: Date)
    {
        self.text = text;
        self.checked = checked;
        self.shouldRemind = shouldRemind;
        self.dueDate = dueDate;
    }
    
    func toggleChecked()
    {
        self.checked = !self.checked
    }
}
