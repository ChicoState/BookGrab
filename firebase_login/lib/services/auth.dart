import 'package:firebase_login/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

//authservice returns a user from firebase auth instance or potentially  null if logged out
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;
  }



  //authenticate changes user stream

    Stream<User> get user {

    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);

    }

    //sign in anonymously
   Future signInAnon() async {

    try {

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e){
      print (e.toString());
      return null;

    }

   }


   //sign in w email and pass

//register w email and pass




//sign out, we use a null return to notify that there has been a signout. the stream will know this.

Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;

    }

}



}