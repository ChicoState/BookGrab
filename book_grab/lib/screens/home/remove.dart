import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Remove extends StatefulWidget {
  final String username;

  const Remove({Key key, this.username}): super(key: key);

  @override
  _RemoveState createState() => _RemoveState();
}

class _RemoveState extends State<Remove> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 0, 1, 1),
        elevation: 0.0,
        title: Text('Remove Book '),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                //get only the books from the current user
                stream: Firestore.instance.collection('books')
                    .where('seller', isEqualTo: '${widget.username}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.documents[index];
                        return  Column(
                            children: <Widget>[
                              Text(ds["name"]),
                              RaisedButton(
                                  color: Colors.red,
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  //delete the book from the user and book collection
                                  onPressed: () {
                                    Firestore.instance.collection("books")
                                        .document(ds['book_id'])
                                        .delete();
                                    Firestore.instance.collection("users")
                                    .document('${widget.username}')
                                    .collection('for_sale')
                                    .document(ds['name'])
                                    .delete();
                                  },
                                ),
                              ],
                        );
                      },
                  );
                }
            ),
            ],
        ),
      ),
    );
  }
}