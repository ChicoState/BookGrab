import 'package:book_grab/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
//property to be accessed from authenticate.dart for toggleview

  final Function toggleView;
  SignIn({this.toggleView});

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
      resizeToAvoidBottomPadding: false,
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(150, 0, 0, .8),
        child: Form(
          //associate global key with our form's validation.
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                widthFactor: 0.3,
                heightFactor: 0.3,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  color: Color.fromRGBO(100, 0, 0, 9),
                  child: Container(
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 450,
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/wild_logo.png',
                              width: 80,
                              height: 80,
                            ),
                          )),

                      // Title text for Book Grab
                      Container(
                        width: 150,
                        child: Text(
                          'Book Grab',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Input fields for username and password

//text field for email with onchanged prop val is contents of formfield, every time value in formfield changes this runs

                      Container(
                        width: 250,
                        child: Material(
                            elevation: 5.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(139, 0, 0, 0.4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Icon(Icons.person, color: Colors.white),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                  ),
                                  width: 200,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'email',
                                            fillColor: Colors.white,
                                            filled: true),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        }),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      //sized box for spacing
                      SizedBox(height: 5.0),
                      Container(
                        width: 250,
                        child: Material(
                            elevation: 5.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(139, 0, 0, 0.4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.lock, color: Colors.white),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                  ),
                                  width: 200,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'password',
                                            fillColor: Colors.white,
                                            filled: true),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        }),
                                  ),
                                ),
                              ],
                            )),
                      ),

                      // login button eventually will be a form
                      Container(
                        width: 150,
                        child: RaisedButton(
                          onPressed: () async {
                            //printing email password combo for debug purposes
                            //print(email);
                            //print(password);
                            if (_formKey.currentState.validate()) {
                              //signin and gather result for this
                              dynamic result = await _auth
                                  .signinWithEmailPassword(email, password);
                              if (result == null) {
                                setState(() => error =
                                    'Couldnt signin with provided info');
                              }
                            }
                          },
                          color: Color.fromRGBO(139, 0, 0, 1),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      //display error
                      SizedBox(height: 8.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        child: RaisedButton(
                            color: Color.fromRGBO(139, 0, 0, 1),
                            textColor: Colors.white,
                            child: Text('Register',
                                style: TextStyle(fontSize: 20.0)),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            onPressed: () {
                              //refer to the widget and call toggleview onpressed
                              widget.toggleView();
                            }),
                      ),

                      Text(
                        'New to BookGrab? Then Register above!',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
