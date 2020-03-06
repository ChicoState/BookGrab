import 'package:book_grab/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:book_grab/models/user.dart';
import 'package:book_grab/screens/authenticate/authenticate.dart';
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