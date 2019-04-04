//
//  UserDefaultsKeys.swift
//  Checklists
//
//  Created by lpiem on 04/04/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit
enum UserDefaultsKeys :  String, Codable, CaseIterable {
    
    case Appointments
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    var value : String {
        return ""
        
    }
}
