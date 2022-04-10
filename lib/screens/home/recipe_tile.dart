import 'package:flutter/material.dart';
import 'package:project_wireless/models/recipe.dart';

class RecipeTile extends StatelessWidget {

  final Recipe recipe;
  RecipeTile({ required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[recipe.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(recipe.name),
          subtitle: Text('Takes ${recipe.sugars} sugar(s)'),
        ),
    )
    );
  }
}
