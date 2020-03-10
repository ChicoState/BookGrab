import 'package:book_grab/services/auth.dart';
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

        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              //text field for email with onchanged prop val is contents of formfield, every time value in formfield changes this runs
              TextFormField(
                onChanged: (val) {


                }
              ),
              //sized box for spacing
              SizedBox(height: 20.0),
              //password form field, obscure text
              TextFormField(
                  obscureText: true,
                  onChanged: (val){


                  
                }

              ),

            ],


          ),


        ),

      ),

    );
  }
}