import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_grab/screens/home/sell.dart';
import 'package:book_grab/screens/home/remove.dart';
import 'package:book_grab/Models/user.dart';

double _width = 250.0;

//going to return an interactive child that can toggle data
class UserButton extends StatefulWidget {
  final DocumentSnapshot ds;

  const UserButton({Key key, this.ds}) : super(key: key);

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
    return Column(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        SizedBox(
          width: _width,
          child: RaisedButton(
            color: Color.fromRGBO(139, 0, 0, 1),
            child: Text(
              "$_username",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _visible = !_visible;
              setState(() {});
            },
          ),
        ),
        Visibility(
          visible: _visible,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(_username)
                  .collection('for_sale')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading...");
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds_book = snapshot.data.documents[index];
                      return Column(
                        children: <Widget>[
                          Text(
                            '${ds_book['name']}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Container(
                            width: _width,
                            child: Table(children: [
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
                              TableRow(children: [
                                Text(' Avalibility'),
                                Text(' ${ds_book['sold'] ? 'Avalibile' : 'Sold'}'),
                              ]),
                            ]),
                          ),
                          Text('\n'),
                        ],
                      );
                    });
              }),
        ),
      ],
    );
  }
}

class InstantSearchBar extends StatefulWidget {
  @override
  _MySearch createState() => _MySearch();
}

class _MySearch extends State<InstantSearchBar> {
  var queryResultSet = [];
  var tempSearchRes = [];
  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchRes = [];
      });
    }
    var capitalized_value =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; i++) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchRes = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalized_value)) {
          setState(() {
            tempSearchRes.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (val) {
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
                    borderRadius: BorderRadius.circular(4.0))),
          )),
      GridView.count(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          crossAxisCount: 1,
          //crossAxisSpacing: 4.0,
          //mainAxisSpacing: 4.0,
          primary: false,
          shrinkWrap: true,
          children: tempSearchRes.map((element) {
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
                Table(children: [
                  TableRow(children: [
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
                  ]),
                  TableRow(children: [
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
                  ]),
                  TableRow(children: [
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
                  ]),
                  TableRow(children: [
                    Text(
                      "Seller:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      "${element['seller']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Price:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      "\$${element['price']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Avalibility:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      "${element['sold'] ? 'Avalible' : 'Sold'}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ]),
                ]),
                RaisedButton(
                  child: Text("Buy"), onPressed: () async {
                    Firestore.instance
                        .collection('books')
                        .document('${element['book_id']}')
                        .updateData({

                      'sold': !element['sold'],
                    });
                    Firestore.instance
                        .collection('users')
                        .document('${element['seller']}')
                        .collection('for_sale')
                        .document('${element['name']}')
                        .updateData({

                      'sold': !element['sold'],
                    });
                    element['sold'] = !element['sold'];
                    setState(() {

                    });
                  }
                )
              ],
            ));
          }).toList())
    ]));
  }
}

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('books')
        .where('search_key',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
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
        backgroundColor: Color.fromRGBO(170, 50, 51, 1),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(140, 0, 1, 1),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.search, color: Colors.white),
                textColor: Colors.white,
                //logout button will call signout on our authservice.
                label: Text('search'),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstantSearchBar()),
                  );
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.person, color: Colors.white),
                textColor: Colors.white,
                //logout button will call signout on our authservice.
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            
            SizedBox(height: 5.0),
            SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                'Book Grab',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 250,
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(139, 0, 0, 0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search, color: Colors.white),
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
                          child: GestureDetector(
                              child: Text("\nSearch for Specific Book"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InstantSearchBar()),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 250,
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(139, 0, 0, 0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add, color: Colors.white),
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
                          child: GestureDetector(
                              child: Text("\nAdd Book for Sale"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Sell(username: user.email)),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
            ),
            
            SizedBox(height: 20.0),
            Container(
              width: 250,
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(139, 0, 0, 0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.remove, color: Colors.white),
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
                          child: GestureDetector(
                              child: Text("\nRemove a Book"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Remove(username: user.email)),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20.0),
            Text(
              "Users currently selling:",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
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
                      });
                }),
          ]),
        ),
      ),
    );
  }
}
