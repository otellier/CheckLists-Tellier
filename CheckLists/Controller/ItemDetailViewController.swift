import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate  {
    
    var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit : ChecklistItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemToEdit = itemToEdit{
            titleTextField.text = itemToEdit.text
            navigationItem.title = "Edit Item"
        }
        
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func isDone(_ sender: Any) {
        if let itemToEdit = itemToEdit {
            itemToEdit.text = titleTextField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: itemToEdit)
        }else{
            delegate?.itemDetailViewController(self, didFinishAddingItem: ChecklistItem(text: titleTextField.text!))
        }
    }
    

    @IBAction func Cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         titleTextField.becomeFirstResponder()
        navigationItem.rightBarButtonItem?.isEnabled = false
        titleTextField.delegate = self
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
    
}

protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}




