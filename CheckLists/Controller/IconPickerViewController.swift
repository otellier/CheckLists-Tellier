//
//  IconePickerViewController.swift
//  CheckLists
//
//  Created by iem on 27/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {

    var delegate: IconPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IconAsset.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "icon", for: indexPath)
        cell.textLabel?.text = IconAsset.allValues[indexPath.row].rawValue
        cell.imageView?.image = IconAsset.allValues[indexPath.row].image
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.iconPickerTableViewController(self, HasChoseIcon: IconAsset.allValues[indexPath.row])
    }


        
}

protocol IconPickerViewControllerDelegate: class{
    func iconPickerTableViewControllerDidCancel(_ controller: IconPickerViewController)
    func iconPickerTableViewController(_ controller: IconPickerViewController, HasChoseIcon icon: IconAsset)
}



