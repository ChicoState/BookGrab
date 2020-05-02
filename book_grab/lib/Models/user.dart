

//basic user class, while we could just use firebase user, this lets us focus in on the data we are concerned with.

class User {


  final String uid;
  final String email;

//constructor takes uid and sets this.uid to it
  User({ this.uid, this.email});


}

