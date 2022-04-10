import 'package:flutter/material.dart';
import 'package:project_wireless/services/auth.dart';
import 'package:project_wireless/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project_wireless/screens/home/recipe_list.dart';
import 'package:project_wireless/models/recipe.dart';
import 'package:project_wireless/screens/home/setting_form.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingForm(),
        );
      });
    }

    return StreamProvider<List<Recipe>>.value(
      value: DatabaseService(uid: '').recipes,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Shared'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: RecipeList()),
      ),
    );
  }
}