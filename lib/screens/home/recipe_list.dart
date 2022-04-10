import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_wireless/models/recipe.dart';
import 'package:project_wireless/screens/home/recipe_tile.dart';

class RecipeList extends StatefulWidget {
  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {

    final recipes = Provider.of<List<Recipe>>(context);

    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeTile(recipe: recipes[index]);
        },
      );
    }
  }
