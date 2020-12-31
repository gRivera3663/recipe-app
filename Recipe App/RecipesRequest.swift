//
//  RecipesRequest.swift
//  Recipe App
//
//  Created by Ismail Hasan on 10/4/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import Foundation

enum RecipesError: Error {
    case noDataAvailable
    case cannotProcessData
}

// gets recipes from search bar
struct RecipesRequest {
    let resourceURL: URL
    let API_KEY = ""
    
    init(param: String) {
        var newParam = ""
        if param.contains(" ") {
            newParam = param.replacingOccurrences(of: " ", with: "%20")
        } else if param.contains("\\") {
            newParam = param.replacingOccurrences(of: "\\", with: "")
        } else {
            newParam = param
        }
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(API_KEY)&query=\(newParam)") else { fatalError() }
        self.resourceURL = url
    }
    
    func getRecipes(completion: @escaping (Result<[ResultInfo], RecipesError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipesResponse = try decoder.decode(Results.self, from: jsonData)
                let recipeDetails = recipesResponse.results
                completion(.success(recipeDetails))
            } catch {
                completion(.failure(.cannotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}

// gets additional info based on ID of the recipe selected by user
struct SoloRecipeRequest {
    let resourceURL: URL
    let API_KEY = ""
        
    init(id: Int) {
        let newID = String(id)
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(newID)/information?apiKey=\(API_KEY)") else { fatalError() }
        self.resourceURL = url
    }
    
    func getIngredients(completion: @escaping (Result<ResultsRecipe, RecipesError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipesResponse = try decoder.decode(ResultsRecipe.self, from: jsonData)
                let recipeDetails = recipesResponse
                completion(.success(recipeDetails))
            } catch {
                completion(.failure(.cannotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}

struct RandomRecipeRequest {
    let resourceURL: URL
    let API_KEY = ""
        
    init() {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?number=3&apiKey=\(API_KEY)") else { fatalError() }
        self.resourceURL = url
    }
    
    func getRandoms(completion: @escaping (Result<[ResultsRecipe], RecipesError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipesResponse = try decoder.decode(FeaturedRecipes.self, from: jsonData)
                let recipeDetails = recipesResponse.recipes
                completion(.success(recipeDetails))
            } catch {
                completion(.failure(.cannotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}
