import 'package:flutter/material.dart';
import 'package:loginpage/app_card.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppCard(
                child: Text("BookGrab",
                  style: TextStyle(fontSize: 32.0),
                  textAlign: TextAlign.center,
                ),
              ),
              AppCard(
                  child: Container(
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Password"),
                          ),
                          Container(
                              width: double.infinity,
                              margin:EdgeInsets.only(top: 20.0),
                              child: FlatButton(
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  onPressed: () {},
                                  child: Text("Login")
                              )
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text("Forgot Password?")
                              )
                          )
                        ]
                    ),
                  )
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    FlatButton(
                        onPressed: () {},
                        child: Text("Sign up")
                    )
                  ]
              )
            ],
          ),
        )
    );
  }
}