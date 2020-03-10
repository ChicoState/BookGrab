import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        //Builds a stream of user snapshots, and creates a list
        //of users emails to display on the home page. Just an example
        //of how we can access fields from the database.
        body: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    return new Row(
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Expanded(child: Text(ds["email"])),
                      ],

                    );
                  }

              );
            }
        ),
      ),
    );
  }
}