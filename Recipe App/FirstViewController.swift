//
//  FirstViewController.swift
//  Recipe App
//
//  Created by CSUFTitan on 9/29/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var listOfRecipes: [ResultInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let recipeRequest = RecipesRequest(param: self.searchBar.text!)
        recipeRequest.getRecipes { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let recipes):
                self?.listOfRecipes = recipes
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRecipes.count != 0 ? listOfRecipes.count : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        cell.textLabel?.text = listOfRecipes.count != 0 ? listOfRecipes[indexPath.row].title : ""
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRecipeDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecipeDetailVC {
            destination.recipe = listOfRecipes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
