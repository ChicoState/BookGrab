import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sell extends StatefulWidget {
  final String username;

  const Sell({Key key, this.username}): super(key: key);

  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  //variables
  String _name = 'placeholder';
  String _author = 'placeholder';
  String _classNo = 'placeholder';
  String _major = 'placeholder';
  String _isbn = 'placeholder';
  String _price = 'placeholder';
  String _search_key = 'placeholder';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(170, 50, 51, 1),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 0, 1, 1),
        elevation: 0.0,
        title: Text('Sell Book '),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            Container( 
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), 
              ),
              child: Text("${widget.username}", textAlign: TextAlign.center,), 
            ),
            //Text('${widget.username}'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(     
                        decoration: InputDecoration(
                          hintText: 'Book Title',
                        ),
                        onChanged: (val) {
                          setState(()=> _name = val);
                          setState(()=> _search_key = val[0]);
                        }
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Book Author',
                        ),
                        onChanged: (val) {
                          setState(()=> _author = val);
                        }
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Class Major',
                        ),
                        onChanged: (val) {
                          setState(()=> _major = val);
                        }
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Class Number',
                        ),
                        onChanged: (val) {
                          setState(()=> _classNo = val);
                        }
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'ISBN',
                        ),
                        onChanged: (val) {
                          setState(()=> _isbn = val);
                        }
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Price',
                        ),
                        onChanged: (val) {
                          setState(()=> _price = val);
                        }
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                      color: Color.fromRGBO(140, 0, 1, 1),
                      child: Text(
                        'Put up for Sale',
                        style: TextStyle(color: Colors.white),
                        //need a style to change color of text


                      ),
                      onPressed: () {
                        Firestore.instance.collection('users').
                          document('${widget.username}').
                          collection('for_sale').document('$_name').setData({
                          'name': _name,
                          'author': _author,
                          'class': _classNo,
                          'major': _major,
                          'isbn': _isbn,
                          'price': _price,
                          'sold': true,
                        });
                        //add() gives us an auto-id, as opposed to setData()
                        Firestore.instance.collection('books').add({
                          'name': _name,
                          'author': _author,
                          'class': _classNo,
                          'major': _major,
                          'isbn': _isbn,
                          'search_key': _search_key,
                          'seller': '${widget.username}',
                          'price': _price,
                          'sold': true,
                        })
                        //this is weirdly written, but the ".then" is needed in order
                        //to get the book_id once it is generated
                        .then((docRef) {
                          Firestore.instance.collection('books').document(docRef.documentID).setData({
                            'book_id': docRef.documentID,
                            'name': _name,
                            'author': _author,
                            'class': _classNo,
                            'major': _major,
                            'isbn': _isbn,
                            'search_key': _search_key,
                            'seller': '${widget.username}',
                            'price': _price,
                            'sold': true,
                        });
                        });
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 275.0),
                  ],
                )
              ),
            ),
          ]
        ),
      ),
    );
  }
}