import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_grab/screens/home/sell.dart';

double _width = 250.0;

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
          width: _width,
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
          child: StreamBuilder(
            stream: Firestore.
                      instance.
                      collection('users').
                      document(widget.ds['username']).
                      collection('for_sale').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds_book = snapshot.data.documents[index];
                  return new Column(
                    children: <Widget>[
                      Text(
                        '${ds_book['name']}',
                        style: new TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      Container(
                        width: _width,
                        child: Table(
                          children: [
                            TableRow(children: [
                              Text(' Major'),
                              Text(' ${ds_book['major']}'),
                            ]),
                            TableRow(children: [
                              Text(' Class'),
                              Text(' ${ds_book['class']}'),
                            ]),
                            TableRow(children: [
                              Text(' Author'),
                              Text(' ${ds_book['author']}'),
                            ]),
                            TableRow(children: [
                              Text(' ISBN'),
                              Text(' ${ds_book['isbn']}'),
                            ]),
                          ]
                        ),
                      ),
                      Text('\n'),
                    ],
                  );
                }
              );
            }
          ),
        ),
        RaisedButton(
          onPressed: ()  {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Sell(
                  ds: widget.ds)),
            );
          },
          child: Text("Add book for sale"),
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
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return UserButton(
                    ds: ds,
                  );
                }
              );
            }
        ),
      ),
    );
  }
}