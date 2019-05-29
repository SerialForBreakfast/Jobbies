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
    
    let itemArray: [String] = ["Eat a potato", "Buy a donkey", "Sell some Lichen"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
}

