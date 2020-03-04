import 'package:flutter/material.dart';
import 'package:firebase_login/screens/wrapper.dart';
import 'package:firebase_login/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_login/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(

     value: AuthService().user,
      child: MaterialApp(

        home: Wrapper(),

      ),


    );
  }
}

