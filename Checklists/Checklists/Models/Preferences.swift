//
//  Preferences.swift
//  Checklists
//
//  Created by lpiem on 04/04/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import Foundation

class PreferencesSingleton
{
    static let sharedInstance = Preferences(id: 0);
}

class Preferences
{
    var itemId : Int;
    
    init(id: Int)
    {
        itemId = id
    }
    
    func nextChecklistItemID() -> Int
    {
        itemId = itemId + 1;
        return itemId;
    }
}
