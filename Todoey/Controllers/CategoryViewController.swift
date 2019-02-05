//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Morgan Hondros on 2/5/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let contextCat = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let request : NSFetchRequest<Item> = Item.fetchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        contextCat.delete(categoryArray[indexPath.row])
        categoryArray.remove(at: indexPath.row)
        
//        saveCategory()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Categories


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newCategory = Category(context: self.contextCat)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
//            self.saveCategory()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveCategories() {
        do {
            
            try contextCat.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try contextCat.fetch(request)
        } catch {
            print("Error in this mug: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
}
