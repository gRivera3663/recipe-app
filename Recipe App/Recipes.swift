//
//  HTMLConnection.swift
//  Recipe App
//
//  Created by Ismail Hasan on 10/3/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import Foundation

// Struct Needed for ResultInfo
struct Results: Decodable {
    var results: [ResultInfo]
    var number: Int
    var totalResults: Int
}

// Result Info for Recipe Search
struct ResultInfo: Decodable {
    var id: Int
    var title: String
    var image: String
}

// Struct Needed for RecipeResultInfo
struct ResultsRecipe: Decodable {
    var extendedIngredients: [IngredientInfo]
    var summary: String
    var instructions: String
    var image: String
    var title: String
}

// Result Info for Indivual Recipe
struct IngredientInfo: Decodable {
    var name: String
}

struct FeaturedRecipes: Decodable {
    var recipes: [ResultsRecipe]
}
