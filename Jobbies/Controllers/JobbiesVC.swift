//
//  ViewController.swift
//  Jobbies
//
//  Created by Joseph McCraw on 5/29/19.
//  Copyright © 2019 Joseph McCraw. All rights reserved.
//

import UIKit

//Free Delegate, Data source and IBOutlet from tableview
class JobbiesVC: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            print("Before defaults.set")
            for i in self.itemArray {
                print(i.title)
            }
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Entry"
            textField = alertTextField
            print(alertTextField.text ?? "No Entry Info")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding array of type: \(error)")
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Clamshells"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Lower Trunk Rotation"
        newItem2.done = true
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Cobra Pose"
        itemArray.append(newItem3)
        
        loadItems()
        
//        if let items = UserDefaults.standard.array(forKey: "JobbiesList") as? [Item] {
//            itemArray = items
//        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Could not decode Item.plist with error: \(error)")
                
            }
        }
    }
}

