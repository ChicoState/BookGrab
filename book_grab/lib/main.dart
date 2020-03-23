import 'package:flutter/material.dart';
import 'package:book_grab/screens/wrapper.dart';
import 'package:book_grab/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:book_grab/models/user.dart';
import 'package:book_grab/screens/home/home.dart';

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

