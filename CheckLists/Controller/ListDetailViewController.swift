//
//  ListDetailViewController.swift
//  CheckLists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var labelIcon: UILabel!
    var delegate: ListDetailViewControllerDelegate?
    var listToEdit : Checklist?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.rightBarButtonItem?.isEnabled = false
        if let listToEdit = listToEdit{
            titleTextField.text = listToEdit.title
            loadIcon(icon: listToEdit.icon)
            navigationItem.title = "Edit List"
        }else{
            loadIcon(icon: IconAsset.Folder)
        }
    }
    
    @IBAction func isDone(_ sender: Any) {
        if let listToEdit = listToEdit {
            listToEdit.title = titleTextField.text!
            listToEdit.icon = IconAsset(rawValue: labelIcon.text!)!
            delegate?.listDetailViewController(self, didFinishEditingItem: listToEdit)
        }else{
            delegate?.listDetailViewController(self, didFinishAddingItem: Checklist(title: titleTextField.text!, icon: IconAsset(rawValue: labelIcon.text!)!))
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleTextField.becomeFirstResponder()
        titleTextField.delegate = self
        
    }
    
    func loadIcon(icon: IconAsset){
        labelIcon.text = icon.rawValue
        imageView.image = icon.image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
            // ...
            if(newString.count==0){
                navigationItem.rightBarButtonItem?.isEnabled = false
            }else{
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
            
        }
        return true
        // ...
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseIcon"
        {
            let destination = segue.destination as! IconPickerViewController
            destination.delegate = self
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
   //   let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
//      cell.isSelected = false
    }


}

extension ListDetailViewController: IconPickerViewControllerDelegate
{
    func iconPickerTableViewControllerDidCancel(_ controller: IconPickerViewController) {
        controller.dismiss(animated: true)
    }
    
    func iconPickerTableViewController(_ controller: IconPickerViewController, HasChoseIcon icon: IconAsset) {
        loadIcon(icon: icon)
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationController?.popViewController(animated: true)
    }
    
    
}
protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem list: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem list: Checklist)
}



