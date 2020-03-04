import 'package:firebase_login/services/auth.dart';
import 'package:flutter/material.dart';



    class SignIn extends StatefulWidget {
      @override
      _SignInState createState() => _SignInState();
    }

    class _SignInState extends State<SignIn> {
      final AuthService _auth = AuthService();
   //create instance of authservice, some slight error checking here if the result is null in our onpressed signin anon button.
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.green[100],
          appBar: AppBar(
            backgroundColor: Colors.green[400],
            elevation: 0.0,
            title: Text('Sign in to bookgrab'),


          ),


          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

            child: RaisedButton(
              child: Text('Sign in anonymously'),
              onPressed: ()async {
                dynamic result = await _auth.signInAnon();
                if (result == null){
                  print('error signing in');
                }
                else{

                  print('signed in');
                  print(result.uid);
                }

              },
            ),


          ),

        );
      }
    }
