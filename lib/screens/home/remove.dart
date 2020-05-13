import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Remove extends StatefulWidget {
  final String username;

  const Remove({Key key, this.username}) : super(key: key);

  @override
  _RemoveState createState() => _RemoveState();
}

class _RemoveState extends State<Remove> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(170, 50, 51, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 0, 1, 1),
        elevation: 0.0,
        title: Text('Remove Book '),
      ),
      body: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          //shrinkWrap: true,
          children: <Widget>[
            StreamBuilder(
                //get only the books from the current user
                stream: Firestore.instance
                    .collection('books')
                    .where('seller', isEqualTo: '${widget.username}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.documents[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(height: 15.0),
                          RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Title: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15.0),
                                ),
                                TextSpan(
                                    text: ds["name"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.underline,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Status: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 10.0),
                                ),
                                TextSpan(
                                    text: (ds["sold"]
                                        ? "Still for Sale"
                                        : "Sold"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 10.0,
                                    )),
                              ],
                            ),
                          ),
                          RaisedButton(
                            color: Color.fromRGBO(139, 0, 0, 1),
                            child: Text(
                              "Remove",
                              style: TextStyle(color: Colors.white),
                            ),
                            //delete the book from the user and book collection
                            onPressed: () {
                              Firestore.instance
                                  .collection("books")
                                  .document(ds['book_id'])
                                  .delete();
                              Firestore.instance
                                  .collection("users")
                                  .document('${widget.username}')
                                  .collection('for_sale')
                                  .document(ds['name'])
                                  .delete();
                            },
                          ),
                          Text(
                            '================================',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
