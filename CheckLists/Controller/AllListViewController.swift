//
//  AllListViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    @IBOutlet weak var listName: UILabel!
    var checkLists = [Checklist]()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Checklists"
//        checkLists.append(Checklist(title: "liste1"))
//        checkLists.append(Checklist(title: "liste2"))
//        checkLists.append(Checklist(title: "liste3"))
//        initLists()
    }

    func initLists(){
        for index in 0...checkLists.count-1 {
            checkLists[index].tasks.append(ChecklistItem(text: checkLists[index].title))
            checkLists[index].tasks.append(ChecklistItem(text: checkLists[index].title))
            checkLists[index].tasks.append(ChecklistItem(text: checkLists[index].title))
            checkLists[index].tasks.append(ChecklistItem(text: checkLists[index].title))
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklist", for: indexPath)
        cell.textLabel?.text = checkLists[indexPath.item].title
        cell.detailTextLabel?.text = writeSubtitle(index: indexPath.row)
        cell.imageView?.image = checkLists[indexPath.row].icon.image
        return cell
    }

    func writeSubtitle(index: Int) -> String {
        switch (checkLists[index].tasks.count, checkLists[index].uncheckedItemsCount) {
        case (0,_):
            return "(No Item)"
        case (_, 0):
            return "All Done!"
        default:
            return String(checkLists[index].uncheckedItemsCount)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checkLists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        DataModel.sharedInstance.cachedLists = checkLists
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewList"
        {
           let destination = segue.destination as! CheckListViewController
           let index = tableView.indexPath(for: sender as! UITableViewCell)!
           //destination.listTitle = checkLists[index.row].title
            destination.list = checkLists[index.row]
        }

        if segue.identifier == "addList"
        {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! ListDetailViewController
            targetController.delegate = self

        }

        if segue.identifier == "editList"
        {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! ListDetailViewController
            //TODO: Envoyer l'item a la case cliqué
            let index = tableView.indexPath(for: sender as! UITableViewCell)!
            targetController.listToEdit = checkLists[index.row]
            targetController.delegate = self

        }
    }

    func save(){
        DataModel.sharedInstance.cachedLists = checkLists
        DataModel.sharedInstance.sortChecklists()
        checkLists = DataModel.sharedInstance.cachedLists
    }

}

extension AllListViewController: ListDetailViewControllerDelegate {
    override func awakeFromNib(){
        DataModel.sharedInstance.loadChecklist()
        checkLists = DataModel.sharedInstance.cachedLists
    }

    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController){
        controller.dismiss(animated: true)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem list: Checklist){
        checkLists.append(list)
        save()
        tableView.reloadData()
//        let indexPath : IndexPath = IndexPath(row: checkLists.count-1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
        controller.dismiss(animated: true)

    }

    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem list: Checklist){
        let listIndex = checkLists.index(where:{ $0 === list })!
        save()
        tableView.reloadData()
//        tableView.reloadRows(at: [IndexPath(row: listIndex, section: 0)], with: .automatic)
        controller.dismiss(animated: true)
    }
}






