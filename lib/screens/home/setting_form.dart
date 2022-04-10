import 'package:flutter/material.dart';
import 'package:project_wireless/services/database.dart';
import 'package:project_wireless/shared/constants.dart';
import 'package:project_wireless/models/myuser.dart';
import 'package:provider/provider.dart';
import 'package:project_wireless/shared/loading.dart';

class SettingForm extends StatefulWidget {

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentRating;

  @override
  Widget build(BuildContext context) {
    Myuser user = Provider.of<Myuser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your recipe settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) => val !=null && val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField<String>(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData?.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged:(val) => setState(() => _currentSugars = val),
                ),
                Slider(
                  value: (_currentRating ?? userData!.rating).toDouble(),
                  activeColor: Colors.brown[_currentRating ?? userData!.rating],
                  inactiveColor: Colors.brown[_currentRating ?? userData!.rating],
                  min:100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentRating = val.round()),
                ),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData!.sugars,_currentName ?? userData!.name, _currentRating ?? userData!.rating
                        );
                      }
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
          } else {
          return Loading();
        }
        }

    );}
  }

