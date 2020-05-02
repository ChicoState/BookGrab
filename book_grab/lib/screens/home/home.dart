import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_grab/screens/home/sell.dart';
import 'package:book_grab/screens/home/remove.dart';
import 'package:book_grab/models/user.dart';

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
  String _username;

  void initState() {
    super.initState();
    widget.ds["user"] == null
        ? _username = widget.ds["username"]
        : _username = widget.ds["user"]["username"];
  }

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
              "$_username",
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
                      document(_username).
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
      ],
    );
  }
}

class InstantSearchBar extends StatefulWidget{
  @override
  _mySearch createState() => _mySearch();
}
class _mySearch extends State<InstantSearchBar>{
  var queryResultSet = [];
  var tempSearchRes = [];
  initiateSearch(value){
    if(value.length == 0){
      setState(() {
        queryResultSet = [];
        tempSearchRes = [];
      });
    }
    var capitalized_value = value.substring(0, 1).toUpperCase() + value.substring(1);
    if(queryResultSet.length == 0 && value.length == 1){
      SearchService().searchByName(value).then((QuerySnapshot docs){
        for(int i = 0; i < docs.documents.length; i++){
          queryResultSet.add(docs.documents[i].data);
        }
      });
    }
    else{
      tempSearchRes = [];
      queryResultSet.forEach((element){
        if(element['name'].startsWith(capitalized_value)){
          setState((){
            tempSearchRes.add(element);
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        body: ListView( children: <Widget>[
          Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
                onChanged: (val){
                  initiateSearch(val);
                },
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: 'Search for textbooks...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0)
                  )
            ),
          )
          ),
        GridView.count(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            primary: false,
            shrinkWrap: true,
            children: tempSearchRes.map((element){
              return Scaffold(
                  body: Column(
                    //padding: EdgeInsets.fromLTRB(10,10,10,0),
                    //height: 220,
                    //width: double.maxFinite,
                    children: <Widget>[
                      Text(
                        "${element['name']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      Table(
                          children: [
                            TableRow(
                                children: [
                                  Text(
                                    "Major:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    "${element['major']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Text(
                                    "Class:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    "${element['class']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Text(
                                    "Author:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    "${element['author']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ]
                            ),
                          ]
                      ),
                      RaisedButton(
                        child: Text("Buy"),
                        onPressed: () {}
                      )
                    ],

                      /*
                      child: Text(
                          "${element['name']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          )
                      )

                       */
                  )
                );
            }).toList())
      ])
    );
  }
}

class SearchService {
  searchByName(String searchField){
    return Firestore.instance.collection('books')
        .where('search_key', isEqualTo: searchField.substring(0,1).toUpperCase())
        .getDocuments();
  }
}


//going to wrap our book list widget and settings form
//this will be a stateless widget
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final User user;
  Home({Key key, this.user}) : super(key: key);

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
        body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            SizedBox(height: 5.0),
            RaisedButton(
              child: Text("Search for Specific Book"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstantSearchBar()),
                );
              }
            ),
            RaisedButton(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sell(
                      username: user.email)),
                );
              },
              child: Text("Add book for sale"),
            ),
            RaisedButton(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Remove(
                      username: user.email)),
                );
              },
              child: Text("Remove a book"),
            ),
            SizedBox(height: 20.0),
             Text("Users currently selling:"),
             StreamBuilder(
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
          ]
        ),
      ),),
    );
  }
}