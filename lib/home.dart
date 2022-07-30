import 'package:flutter/material.dart';
import 'recipecard.dart';
import 'recipe.api.dart';
import 'recipe.dart';
import 'recipedetail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food Recipe')
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(_recipes.length);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => details(
                          recipes: _recipes[index].name.toString(),
                          recipesindex: index.toString(),
                        ),
                      ),
                    );
                  },
                  child: RecipeCard(
                    title: _recipes[index].name.toString(),
                    cookTime: _recipes[index].totalTime.toString(),
                    rating: _recipes[index].rating.toString(),
                    thumbnailUrl: _recipes[index].images.toString(),
                  ),
                );
              },
            ),
    );
  }
}
