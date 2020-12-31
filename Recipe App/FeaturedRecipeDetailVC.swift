//
//  FeaturedRecipeDetailVC.swift
//  Recipe App
//
//  Created by CSUFTitan on 11/11/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import UIKit

class FeaturedRecipeDetailVC: UIViewController {
    var recipeInfo: ResultsRecipe?
    var ingredientsArray = [Grocery]()
    
    @IBOutlet var recipePic: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var recipeSummary: UITextView!
    @IBOutlet var recipeIngredients: UITextView!
    @IBOutlet var recipeDirections: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _: ResultsRecipe = recipeInfo {
            changeLabels()
        }
    }
    
    func changeLabels() {
        let imageURLString = "\(recipeInfo!.image)"
        let imageURL = URL(string: imageURLString)
        let imageData = try! Data(contentsOf: imageURL!)
        let recipeImg = UIImage(data: imageData)
        recipePic.image = recipeImg
        
        recipeName.text = recipeInfo?.title
        recipeSummary.attributedText = recipeInfo?.summary.htmlAttributedString()
        
        let ingredients = recipeInfo?.extendedIngredients
        var text = ""
        for x in ingredients! {
            text += "\(x.name)\n"
            
            ingredientsArray.append(Grocery(name2: x.name))
        }
        
        recipeIngredients.text = text
        
        recipeDirections.attributedText = recipeInfo?.instructions.htmlAttributedString()
    }
    
    @IBAction func onButtonTap(_ sender: Any) {
        var secondTab = tabBarController!.viewControllers![2] as! SecondViewController
        secondTab.groceries += ingredientsArray
        tabBarController?.selectedIndex = 2
    }
}
