import 'package:flutter/material.dart';
import 'package:project_wireless/screens/authenticate/authenticate.dart';
import 'package:project_wireless/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:project_wireless/models/myuser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    final myuser = Provider.of<Myuser?>(context);
    if (myuser == null) {
      return Authenticate();
    } else {
      return Home();
    }
    }
  }