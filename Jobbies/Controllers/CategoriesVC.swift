//
//  CategoryTVC.swift
//  Jobbies
//
//  Created by Joseph McCraw on 5/31/19.
//  Copyright © 2019 Joseph McCraw. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoriesVC: SwipeTableViewController {
    var categories: Results<Category>?
    let defaults = UserDefaults.standard
    let realm = try! Realm()
    
    
    
    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(textField.text!)
            let newCategory = Category()
            newCategory.name = textField.text!
            let bgColor = UIColor.randomFlat
            newCategory.hexColor = bgColor.hexValue()
            
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            print(alertTextField.text ?? "No Entry Info")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("🚩Error saving context: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    override func updateModel(at indexPath: IndexPath) {
        //Update Data Model
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting Category: \(error)")
            }
        }
        
    }

    
    //    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
    //        let request : NSFetchRequest<Item> = Item.fetchRequest()
    //        do {
    //            categoryArray = try context.fetch(request)
    //        } catch {
    //            print("🚩Error fetching Categories from context: \(error)")
    //        }
    //        self.tableView.reloadData()
    //    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 100.0
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].hexColor)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! JobbiesVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            destinationVC.title = categories?[indexPath.row].name
        }
    }
}

//
//extension CategoriesVC: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//        print(searchBar.text)
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadCategories(with: request)
//
//        tableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            print("Count is 0")
//            loadCategories()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}
