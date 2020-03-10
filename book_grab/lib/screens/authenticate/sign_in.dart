import 'package:book_grab/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

//property to be accessed from authenticate.dart for toggleview

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  //create instance of authservice, some slight error checking here if the result is null in our onpressed signin anon button.

  //text field state of email
  String email = ' ';
  //text field state of password
  String password = ' ';
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
        title: Text('Sign in to bookgrab'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            //function that switches us from one screen to another
            onPressed: (){
              //refer to the widget and call toggleview onpressed
              widget.toggleView();
            }
          )


        ],


      ),


      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),

        child: Form(
          //associate global key with our form's validation.
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              //text field for email with onchanged prop val is contents of formfield, every time value in formfield changes this runs
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'email',
                ),
                onChanged: (val) {
                setState(()=> email = val);

                }
              ),
              //sized box for spacing
              SizedBox(height: 5.0),
              //password form field, obscure text
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                ),
                onChanged: (val){
                setState(()=> password = val);

                }

              ),
              SizedBox(height: 5.0),
              RaisedButton(
                color: Colors.green[500],
                child: Text(
                   'Sign in',
                    style: TextStyle(color: Colors.white),
                    //need a style to change color of text


              ),
                  //Asynchronous function as we want to go out and interact with firebase to sign the user in. (so it will take time, thus async)
                  onPressed: () async {
                   //printing email password combo for debug purposes
                    //print(email);
                    //print(password);
                    if (_formKey.currentState.validate()){
                      //signin and gather result for this
                      dynamic result = await _auth.signinWithEmailPassword(email, password);
                     if (result == null){
                       setState(() => error = 'Couldnt signin with provided info');
                     }
                    }
                  }


                ),
              //display error
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