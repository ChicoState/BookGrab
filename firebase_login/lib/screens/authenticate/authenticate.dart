import 'package:flutter/material.dart';
import 'package:firebase_login/screens/authenticate/sign_in.dart';
//This will serve as authentication page for app



    class Authenticate extends StatefulWidget {
      @override
      _AuthenticateState createState() => _AuthenticateState();
    }
    
    class _AuthenticateState extends State<Authenticate> {
      @override
      Widget build(BuildContext context) {
       //authenticate returns sign in
        return Container(
          child: SignIn(),

        );
      }
    }
    