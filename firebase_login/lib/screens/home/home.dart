import 'package:flutter/material.dart';
import 'package:firebase_login/services/auth.dart';
//going to wrap our book list widget and settings form
//this will be a stateless widget
class Home extends StatelessWidget {

    final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(

        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text('BookGrab'),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
//logout button will call signout on our authservice.
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {

                await _auth.signOut();
              },


            ),



          ],


        ),



      ),
    );

  }
}
