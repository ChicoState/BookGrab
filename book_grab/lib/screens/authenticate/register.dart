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
  //errorstring
  String error = '';

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
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 50.0),

        child: Form(
          //this will allow us to keep track of the form and validate it in the future if needed.
          key: _formKey,



          child: Column(
            children: <Widget>[
              SizedBox(height: 2.0),
              //text field for email with onchanged prop val is contents of formfield, every time value in formfield changes this runs
              TextFormField(
                  //functionality to validate inputs
                //if empty return helpstring
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(()=> email = val);

                  }
              ),
              //sized box for spacing
              SizedBox(height: 2.0),
              //password form field, obscure text
              TextFormField(
                  obscureText: true,
                  validator: (val) => val.length < 8  ? 'Enter a password of atleast 8 chars' : null,
                  onChanged: (val){

                    setState(()=> password = val);

                  }

              ),
              SizedBox(height: 2.0),
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
                  //print(email);
                  //print(password);
                  //if the form is valid when this button is pressed, we want the function to trigger. otherwise, prompt user to fill in vals
                  //if  this's false input is not valid , note that it is running two validators (email and password, which are above
                  if (_formKey.currentState.validate()){
                     //register and gather result for this
                    dynamic result = await _auth.registerWithEmailPassword(email, password);

                    if (result == null){
                      setState(() => error = 'Please provide valid register values.');
                    }
                    else {
                      //automatically user is signin
                    }

                   }
                },

              ),

              //should display error 'Please provid valid register values', apparently bottom buffer on the screen is being overflowed by some pixels, only when we are entering values
              SizedBox(height: 8.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 10.0),
              ),


            ],


          ),


        ),

      ),

    );
  }
}
