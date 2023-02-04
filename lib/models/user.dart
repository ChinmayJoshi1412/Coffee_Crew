class FirebaseUser{
  final String uid;
  FirebaseUser(this.uid);
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;
  final String note;
  final int tilecolor;
  UserData(this.uid,this.name,this.sugars,this.strength,this.note,this.tilecolor);
}