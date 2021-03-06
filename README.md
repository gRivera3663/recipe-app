# recipe-app
iOS app where you can search recipes and create grocery lists.

This was a group project for CPSC 223W (Swift Programming).
The group members are Jasen Castillo and Ismail Hasan.

## Responsibilities
Jasen: Checklist and Checklist formatting

Ismail: API functionality, search feature/page, Checklist data saving

Gabriel (me): Storyboard / Auto Layout / Constraints, Recipe Detail pages, Featured page

## Images / Functions

This is the starting page of the application.
Here we feature some random recipes generated by the Spoonacular API (used for recipes).

![](https://github.com/gRivera3663/recipe-app/blob/main/recipefeatured.png)


There is a search feature of the application.
Here we can search for recipes from the API, and then get results based on that search.

![](https://github.com/gRivera3663/recipe-app/blob/main/recipesearch.png)


If we tap on one of these search results, or any recipe we see on the app, we then go to the detailed view of this recipe.
Here we see the image, title of the recipe, a basic description, ingredients, and directions of the recipe.
Some of these may be blank, as the recipes from the API are user created/generated and those users may not have added info for those sections.

![](https://github.com/gRivera3663/recipe-app/blob/main/recipedetail.png)
![](https://github.com/gRivera3663/recipe-app/blob/main/recipeings.png)
![](https://github.com/gRivera3663/recipe-app/blob/main/recipedir.png)


When you click on the "add to list" button, those recipe's ingredients get added to the master grocery list.
Here you can check off ingredients, and clear any ingredients you may have already.
![](https://github.com/gRivera3663/recipe-app/blob/main/recipechecklist.png)
