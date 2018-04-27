//
//  ViewController.swift
//  CheckLists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var list: Checklist!
    var listTitle : String?
//    var documentDirectory: URL {
//            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    }
//
//    var dataFileUrl: URL {
//            return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = list.title
//        if let listTitle = listTitle {
//            navigationItem.title = listTitle
//        }
//        items.append(ChecklistItem(text: "Je suis un Jozua farfelu"))
//        items.append(ChecklistItem(text: "Moi une abeille des temps anciens", checked: true))
//        items.append(ChecklistItem(text: "Et moi un chameau jouant du pipo"))
       // print(dataFileUrl.absoluteString)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        //cell.textLabel?.text = items[indexPath.item].text
        //cell.textLabel?.text = "Je suis une chèvre asthmatique"
        configureText(for: cell, withItem: list.tasks[indexPath.item])
        configureCheckmark(for: cell, withItem: list.tasks[indexPath.item])
        return cell
    }
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem) {
        //cell.accessoryType = (item.checked) ? .checkmark : .none
        let myCell = cell as! ChecklistItemCell
        myCell.checkLabel.isHidden = (item.checked) ? false : true
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        let myCell = cell as! ChecklistItemCell
        myCell.nameLabel.text = item.text
    
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        list.tasks[indexPath.item].toggleChecked()
        configureCheckmark(for: cell, withItem: list.tasks[indexPath.item])
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.tasks.remove(at: indexPath.item)
//        saveChecklistItems()
        DataModel.sharedInstance.saveItems(list: list)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    @IBAction func addDummyToDo(_ sender: Any) {
        list.tasks.append(ChecklistItem(text: "Je suis une chèvre d'Ouganda"))
        let indexPath : IndexPath = IndexPath(row: list.tasks.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"
        {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! ItemDetailViewController
            targetController.delegate = self
            
        }
        
        if segue.identifier == "editItem"
        {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! ItemDetailViewController
            //TODO: Envoyer l'item a la case cliqué
            let index = tableView.indexPath(for: sender as! ChecklistItemCell)!
            targetController.itemToEdit = list.tasks[index.row]
            targetController.delegate = self
            
        }
    }
//    func saveChecklistItems(){
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        let data = try! encoder.encode(items)
//        print(String(data: data, encoding: .utf8)!)
//        try! data.write(to: dataFileUrl)
//    }
//
//    func loadChecklistItems(){
//        if FileManager.default.fileExists(atPath: dataFileUrl.path) {
//            let data = try? Data(contentsOf: dataFileUrl)
//            let decoder = JSONDecoder()
//            let itemsLoaded = try? decoder.decode(Array<ChecklistItem>.self, from: data!)
//            items = itemsLoaded!
//        }
//    }
    

  
}

extension CheckListViewController: ItemDetailViewControllerDelegate {
    override func awakeFromNib(){
//        try? loadChecklistItems()
        
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController){
        controller.dismiss(animated: true)
    }
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem){
        list.tasks.append(item)
        DataModel.sharedInstance.saveItems(list: list)
        tableView.reloadData()
//        let indexPath : IndexPath = IndexPath(row: list.tasks.count-1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
         controller.dismiss(animated: true)
//        saveChecklistItems()
        
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem){
        let itemIndex = list.tasks.index(where:{ $0 === item })!
        DataModel.sharedInstance.saveItems(list: list)
        tableView.reloadData()
//        tableView.reloadRows(at: [IndexPath(row: itemIndex, section: 0)], with: .automatic)
        controller.dismiss(animated: true)
//    saveChecklistItems()
    }
}

