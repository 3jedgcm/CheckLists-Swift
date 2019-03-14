//
//  Checklist.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//


import Foundation

class Checklist: Codable  {
    var list : [ChecklistItem] = [];
    var name : String = "";
    var icon : IconAsset = IconAsset.NoIcon
    var uncheckedItemsCount: String {
        var temp = 0
        for item in list {
            if(!item.checked)
            {
                temp = temp + 1
            }
        }
        if(temp == 0)
        {
            return "All Done"
        }
        else
        {
            return temp.description
        }
    }
    
    init(list:[ChecklistItem],name:String,icon:IconAsset)
    {
        self.icon = icon;
        self.list = list;
        self.name = name;
    }
    
    init()
    {

    }
    

}
