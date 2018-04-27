//
//  DataModel.swift
//  CheckLists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class DataModel{
    
    static let sharedInstance = DataModel()
    
    
    
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("CheckListsToLoad").appendingPathExtension("json")
    }
    
    var cachedLists = Array<Checklist>()
    
    private init() {
        loadChecklist()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveChecklist),
            name: .UIApplicationDidEnterBackground,
            object: nil)
    }
    
    func saveItems(list : Checklist){
        let listIndex = cachedLists.index(where:{ $0 === list })!
        cachedLists[listIndex]=list
        sortChecklists()
    }
    
    @objc func saveChecklist(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(cachedLists)
        print(String(data: data, encoding: .utf8)!)
        try! data.write(to: dataFileUrl)
    }
    
    func loadChecklist(){
        if FileManager.default.fileExists(atPath: dataFileUrl.path) {
            let data = try? Data(contentsOf: dataFileUrl)
            let decoder = JSONDecoder()
            let listsLoaded = try? decoder.decode(Array<Checklist>.self, from: data!)
            cachedLists = listsLoaded!
        }
    }
    
    func sortChecklists(){
        cachedLists = cachedLists.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == ComparisonResult.orderedAscending }
        for index in 0...cachedLists.count-1{
            cachedLists[index].tasks = cachedLists[index].tasks.sorted { $0.text.localizedCaseInsensitiveCompare($1.text) == ComparisonResult.orderedAscending }
        }
    }
    
}
