//
//  ChecklistItem.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import Foundation

class CheckListItem {
    var text = "";
    var checked = false;
    
    init(text:String)
    {
        self.text = text;
    }
    
    init(text:String, checked:Bool)
    {
        self.text = text;
        self.checked = checked;
    }
    
    func toggleChecked()
    {
        self.checked = !self.checked
    }
}
