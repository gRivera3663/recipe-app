//
//  Recipe_AppTests.swift
//  Recipe AppTests
//
//  Created by CSUFTitan on 9/29/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import XCTest
@testable import Recipe_App

class Recipe_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipeRequest() {
        let request = RecipesRequest(param: "eggs")
        var worked = false
        request.getRecipes { [weak self] result in
            
            switch result {
            case .failure:
                worked = false
                
            case .success:
                worked = true
            }
            
            XCTAssertTrue(worked)
        }
    }
    
    func testSoloRecipeRequest() {
        let solorequest = SoloRecipeRequest(id: 716429)
        var worked = false
        solorequest.getIngredients { [weak self] result in
            
            switch result {
            case .failure(let error):
                print("This is the error \(error)")
                worked = false
                
            case .success:
                worked = true
            }
            XCTAssertTrue(worked)
        }
        
    }
    
    func testRandomRecipesRequest() {
        let request = RandomRecipeRequest()
        var worked = false
        request.getRandoms { [weak self] result in
            
            switch result {
            
            case .success:
                worked = true
                
            case .failure:
                worked = false
                
            XCTAssertTrue(worked)
            
            }
            
        }
    }
    
    func testRecipesStruct() {
        let request = RecipesRequest(param: "eggs")
        var recipes = [ResultInfo]()
        request.getRecipes { [weak self] result in
            
            switch result {
            case .failure:
                print("rip")
                
            case .success(let newRecipes):
                recipes = newRecipes
            }
            
            XCTAssertEqual(recipes.count, 10)
        }
    }

}
