//
//  SecondViewController.swift
//  Recipe App
//
//  Created by CSUFTitan on 9/29/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, buttonChange {
    var groceries: [Grocery] = []
    let userDefaults = UserDefaults.standard

    func addButton(name: String) {
        groceries.append(Grocery(name2: name))
        tableView.reloadData()
    }
    
    func buttonChange(checked: Bool, index: Int) {
        groceries[index].checked = checked
        tableView.reloadData()
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        getData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCheckList", for: indexPath) as! GroceryCell
        cell.groceryList.text = groceries[indexPath.row].name
        let checkedBox = UIImage(named: "boxChecked")
        let notCheckedBox = UIImage(named: "boxUnchecked")
        if groceries[indexPath.row].checked {
            cell.checkBox.setBackgroundImage(checkedBox, for: UIControl.State.normal)
        } else {
            cell.checkBox.setBackgroundImage(notCheckedBox, for: UIControl.State.normal)
        }
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.groceries = groceries
        saveData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    func saveData() {
        let data = try? JSONEncoder().encode(groceries)
        userDefaults.set(data, forKey: "checklist")
        print("saved")
    }

    func getData() {
        do {
            if let storedObjItem = userDefaults.object(forKey: "checklist") {
                let storedItems = try JSONDecoder().decode([Grocery].self, from: storedObjItem as! Data)
                groceries = storedItems
            }
        } catch let err {
            print(err)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        groceries = []
        tableView.reloadData()
        saveData()
    }

}

class Grocery: Codable {
    var name = ""
    var checked = false
    
    init(name2: String) {
        self.name = name2
    }
}
