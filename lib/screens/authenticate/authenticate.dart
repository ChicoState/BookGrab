import 'package:book_grab/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:book_grab/screens/authenticate/sign_in.dart';
//This will serve as authentication page for app



class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  //functionality for switching between signin/register screens, respective onpress functions activate this in sign_in.dart and register.dart

  bool showSignedIn = true;
  //function to toggle view establishing this functionality   !showSignedin means to set it to opposite value of what it is, so if true then false
  void toggleView(){
    setState(() => showSignedIn = !showSignedIn);

  }

  @override
  Widget build(BuildContext context) {
    //authenticate returns sign in widget or register widget
      //return sign in in first case, register in other

    //pass down toggleview parameter so we can keep changes.
      if (showSignedIn) {
        return SignIn(toggleView: toggleView);
    }
      else {
        return Register(toggleView: toggleView);
      }

  }
}