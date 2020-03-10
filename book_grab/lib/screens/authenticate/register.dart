import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';

class Register extends StatefulWidget {
  //property to be accessed from authenticate.dart for toggleview

  final Function toggleView;
  Register({ this.toggleView });


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _auth = AuthService();
  //text field states (password, email)
  String email = '';
  String password = '';
  
//key will be used to identify form
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Register '),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              //function that switches us from one screen to another
              onPressed: (){
                //reference the widget when calling toggleview onpressed
                widget.toggleView();
              }
          )


        ],



      ),


      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              //text field for email with onchanged prop val is contents of formfield, every time value in formfield changes this runs
              TextFormField(
                  onChanged: (val) {
                    setState(()=> email = val);

                  }
              ),
              //sized box for spacing
              SizedBox(height: 10.0),
              //password form field, obscure text
              TextFormField(
                  obscureText: true,
                  onChanged: (val){

                    setState(()=> password = val);

                  }

              ),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.green[500],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                  //need a style to change color of text


                ),
                //Asynchronous function as we want to go out and interact with firebase to sign the user in. (so it will take time, thus async)
                onPressed: () async {
                  //printing email password combo for debug purposes
                  print(email);
                  print(password);

                },

              )




            ],


          ),


        ),

      ),

    );
  }
}
