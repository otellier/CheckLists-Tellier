//
//  checklists.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class Checklist : Codable {
    var title: String
    var tasks = Array<ChecklistItem>()
    var icon: IconAsset
    var uncheckedItemsCount: Int{
//        var count: Int = 0
//        for index in 0...tasks.count-1{
//            if(!tasks[index].checked){
//                count+=1
//            }
//        }
        return tasks.filter{!$0.checked}.count
    
    }
    
    init(title: String, tasks: Array<ChecklistItem> = Array<ChecklistItem>(), icon: IconAsset = IconAsset.NoIcon ){
        self.title=title
        self.tasks=tasks
        self.icon=icon
    }
}
