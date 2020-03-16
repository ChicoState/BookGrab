import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//going to return an interactive child that can toggle data
class UserButton extends StatefulWidget {
  final DocumentSnapshot ds;

  const UserButton({Key key, this.ds}): super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserButton> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return new Column(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: RaisedButton(
            color: Colors.green,
            child: Text(
              '${widget.ds["username"]}',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _visible = !_visible;
              setState(() {

              });
            },
          ),
        ),
        Visibility(
            visible: _visible,
            child: new Column(
              children: <Widget>[
                
              ]
            )
        ),
      ],
    );
  }
}

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
        //of users usernames to display on the home page. Just an example
        //of how we can access fields from the database.
        body: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return UserButton(
                    ds: ds,
                  );
                  /*
                  bool _show = false;
                  return new Column(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text(
                            '${ds["username"]}',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _show = !_show;
                            print(_show);
                          },
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: (Text('$_show'))
                      ),
                    ],
                  );

                   */
                }
              );
            }
        ),
      ),
    );
  }
}