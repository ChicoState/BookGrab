import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  //property to be accessed from authenticate.dart for toggleview

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  //text field states (password, email)
  String email = '';
  String password = '';
  //errorstring
  String error = '';

//key will be used to identify form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, // fixes overflow
      backgroundColor: Color.fromRGBO(170, 50, 51, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 0, 1, 1),
        elevation: 0.0,
        title: Text('Register '),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Sign In'),
              textColor: Colors.white,
              //function that switches us from one screen to another
              onPressed: () {
                //reference the widget when calling toggleview onpressed
                widget.toggleView();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Form(
          //this will allow us to keep track of the form and validate it in the future if needed.
          key: _formKey,

          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              //text field for email with onchanged prop val is contents of formfield, every time value in formfield changes this runs
              TextFormField(
                  //functionality to validate inputs
                  //if empty return helpstring
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email@mail.school.edu',
                      fillColor: Colors.white,
                      filled: true),
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              //sized box for spacing
              SizedBox(height: 15.0),
              //password form field, obscure text
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'password (8 or more characters)',
                      fillColor: Colors.white,
                      filled: true),
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  onChanged: (val) {
                    setState(() => password = val);
                  }),

              SizedBox(height: 10.0),

              RaisedButton(
                color: Color.fromRGBO(139, 0, 0, 1),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  //need a style to change color of text
                ),
                //Asynchronous function as we want to go out and interact with firebase to sign the user in. (so it will take time, thus async)
                onPressed: () async {
                  //printing email password combo for debug purposes
                  //print(email);
                  //print(password);
                  //if the form is valid when this button is pressed, we want the function to trigger. otherwise, prompt user to fill in vals
                  //if  this's false input is not valid , note that it is running two validators (email and password, which are above
                  if (_formKey.currentState.validate()) {
                    //register and gather result for this
                    dynamic result =
                        await _auth.registerWithEmailPassword(email, password);

                    if (result == null) {
                      setState(() =>
                          error = 'Please provide valid register values.');
                    }

                    //else registration was valid and we can attempt to add user to firestore.

                    Firestore.instance.runTransaction((transaction) async {
                      await transaction.set(
                          Firestore.instance
                              .collection("users")
                              .document('$email'),
                          {
                            'user': {
                              'email': email,
                              'password': password,
                              'username': email,
                            }
                          });
                    });
                  }
                },
              ),

              //should display error 'Please provid valid register values', apparently bottom buffer on the screen is being overflowed by some pixels, only when we are entering values
              SizedBox(height: 8.0),
              Text(
                error,
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
