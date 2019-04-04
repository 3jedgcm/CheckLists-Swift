//
//  DataModel.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import Foundation
import UIKit

class DataSingleton
{
    static let sharedInstance = DataModel()
}

class DataModel
{
    var documentDirectory: URL?
    var dataFileUrl : URL?
    var itemList: [Checklist] = []
    init()
    {
        UserDefaults.standard.register(defaults: ["firstLaunch":true])

            NotificationCenter.default.addObserver( self,selector: #selector(save),name: UIApplication.didEnterBackgroundNotification,object: nil)
            documentDirectory = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask)[0]
            dataFileUrl = documentDirectory?.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    func load()
    {
        if(UserDefaults.standard.bool(forKey: "firstLaunch"))
        {
            itemList = [Checklist(list: [ChecklistItem(text: "Default", checked: false)], name: "Default", icon: IconAsset.Folder)]
        }
        else
        {
            let decoder = JSONDecoder()
            do {
                if(FileManager.default.fileExists(atPath: dataFileUrl!.path))
                {
                    let data = try Data(contentsOf: dataFileUrl!)
                    itemList = try decoder.decode([Checklist].self, from: data)
                }
            } catch {
                print(error)
            }
        }
    }
    
    @objc
    func save()
    {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(itemList)
            try data.write(to:dataFileUrl!.absoluteURL)
            
        } catch {
            print(error)
        }
    }
    
    
    func sortChecklists()
    {
        itemList.sort(by:{return $0.name < $1.name})
    }
}
