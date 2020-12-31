//
//  RecipeDetailVC.swift
//  Recipe App
//
//  Created by CSUFTitan on 10/6/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import UIKit

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}

class RecipeDetailVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var recipeSummary: UITextView!
    @IBOutlet var recipeIngredients: UITextView!
    @IBOutlet var recipeDirections: UITextView!
    @IBOutlet var addRecipesButton: UIButton!
    
    var recipe: ResultInfo?
    var additionalRecipeInfo: ResultsRecipe?
    var ingredientsArray = [Grocery]()
    
    override func viewDidLoad() {
        changeLabels()
        super.viewDidLoad()
    }
    
    func searchForRecipe(id: Int) {
        let recipeRequest = SoloRecipeRequest(id: id)
        recipeRequest.getIngredients { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error of Recipe: ", error)
            case .success(let info):
                self?.additionalRecipeInfo = info
                DispatchQueue.main.async {
                    let ingredients = self?.additionalRecipeInfo?.extendedIngredients
                    var ingText = ""
                    for x in ingredients! {
                        ingText += "\(x.name) \n"
                        self?.ingredientsArray.append(Grocery(name2: x.name))
                    }
                    self?.recipeIngredients.text = ingText
                    self?.recipeSummary.attributedText = self?.additionalRecipeInfo?.summary.htmlAttributedString()
                    self?.recipeDirections.attributedText = self?.additionalRecipeInfo?.instructions.htmlAttributedString()
                }
            }
        }
    }
    
    func changeLabels() {
        if let recipe: ResultInfo = recipe {
            recipeTitle.text = "\(recipe.title)"
            
            let imageURLString = "\(recipe.image)"
            let imageURL = URL(string: imageURLString)
            let imageData = try! Data(contentsOf: imageURL!)
            let recipeImg = UIImage(data: imageData)
            recipeImage.image = recipeImg
            searchForRecipe(id: recipe.id)
        }
    }
    
    @IBAction func onButtonTapped(_ sender: Any) {
        var secondTab = tabBarController!.viewControllers![2] as! SecondViewController
        secondTab.groceries += ingredientsArray
        tabBarController?.selectedIndex = 2
    }
}
