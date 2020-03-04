import 'package:firebase_login/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/models/user.dart';
import 'package:firebase_login/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   //return either Home or authenticate widget

    final user = Provider.of<User>(context);
    print(user);

    //return home or auth widget based on null/user val, these are the two screens which depend on the status of the user object.

    if (user == null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}
