import 'package:flutter/material.dart';
import 'package:book_grab/services/auth.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Sell Book '),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('${widget.username}'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Book Title',
                        ),
                        onChanged: (val) {
                          setState(()=> _name = val);
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
                    RaisedButton(
                      color: Colors.green[500],
                      child: Text(
                        'Put up for Sale',
                        style: TextStyle(color: Colors.white),
                        //need a style to change color of text


                      ),
                      //Asynchronous function as we want to go out and interact with firebase to sign the user in. (so it will take time, thus async)
                      onPressed: () async {
                        /*
                        final Map<String, dynamic> data = {
                          'name': _name,
                          'author': _author,
                          'class': _classNo,
                          'major': _major,
                          'isbn': _isbn,
                        };
                        */
                        Firestore.instance.collection('users').
                          document('${widget.username}').
                          collection('for_sale').document('$_name').setData({
                          'name': _name,
                          'author': _author,
                          'class': _classNo,
                          'major': _major,
                          'isbn': _isbn,
                        });
                        Navigator.pop(context);
                      },
                    ),
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