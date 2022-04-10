import 'package:flutter/material.dart';
import 'package:project_wireless/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_wireless/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:project_wireless/models/myuser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<Myuser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
