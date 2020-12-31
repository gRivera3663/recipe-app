//
//  ThirdViewController.swift
//  Recipe App
//
//  Created by CSUFTitan on 11/10/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    var featured: [ResultsRecipe] = []
    
    @IBOutlet var recipe1Image: UIImageView!
    @IBOutlet var recipe1Name: UILabel!
    
    @IBOutlet var recipe2Image: UIImageView!
    @IBOutlet var recipe2Name: UILabel!
    
    @IBOutlet var recipe3Image: UIImageView!
    @IBOutlet var recipe3Name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFeatured()
    }
    
    func getFeatured() {
        let request = RandomRecipeRequest()
        request.getRandoms { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error of Recipe: ", error)
            case .success(let recipes):
                self?.featured = recipes
                
                DispatchQueue.main.async {
                    let r = recipes
                    
                    // sets up the taps for each picture
                    self!.setTaps(r[0], r[1], r[2])
                    
                    // changes text for recipes
                    self!.recipe1Name.text = r[0].title
                    self!.recipe2Name.text = r[1].title
                    self!.recipe3Name.text = r[2].title
                    
                    // changes pictures for recipes
                    self!.recipe1Image.image = self!.convertToImage(image: r[0].image)
                    self!.recipe2Image.image = self!.convertToImage(image: r[1].image)
                    self!.recipe3Image.image = self!.convertToImage(image: r[2].image)
                }
            }
        }
    }
    
    func convertToImage(image: String) -> UIImage {
        let newImage = "\(image)"
        let imageURL = URL(string: newImage)
        let imageData = try! Data(contentsOf: imageURL!)
        let recipeImg = UIImage(data: imageData)
        return recipeImg!
    }
    
    func setTaps(_ one: ResultsRecipe, _ two: ResultsRecipe, _ three: ResultsRecipe) {
        let tap = customTap(target: self, action: #selector(recipe1Response(gesture:)))
        tap.info = one
        recipe1Image.addGestureRecognizer(tap)
        recipe1Image.isUserInteractionEnabled = true
        
        let tap2 = customTap(target: self, action: #selector(recipe2Response(gesture:)))
        tap2.info = two
        recipe2Image.addGestureRecognizer(tap2)
        recipe2Image.isUserInteractionEnabled = true
        
        let tap3 = customTap(target: self, action: #selector(recipe3Response(gesture:)))
        tap3.info = three
        recipe3Image.addGestureRecognizer(tap3)
        recipe3Image.isUserInteractionEnabled = true
    }
    
    @objc func recipe1Response(gesture: customTap) {
        performSegue(withIdentifier: "featured", sender: gesture.info)
    }
    
    @objc func recipe2Response(gesture: customTap) {
        performSegue(withIdentifier: "featured", sender: gesture.info)
    }
    
    @objc func recipe3Response(gesture: customTap) {
        performSegue(withIdentifier: "featured", sender: gesture.info)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FeaturedRecipeDetailVC {
            destination.recipeInfo = sender as! ResultsRecipe
        }
    }
}

class customTap: UITapGestureRecognizer {
    var info: ResultsRecipe?
}
