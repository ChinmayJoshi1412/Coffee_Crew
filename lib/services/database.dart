import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
class DatabaseService{
  final String uid;
  DatabaseService(this.uid);
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strength) async
  {
    return await brewCollection.doc(uid).set({
    'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }
  List<Brew> brewlistfromsnapshot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return Brew(
          doc['name'] ?? '',
          doc['strength'] ?? 0,
          doc['sugars']??'0');
    }).toList();
  }

  UserData userdatafromsnapshot(DocumentSnapshot snapshot)
  {
    return UserData(uid, snapshot['name'], snapshot['sugars'],snapshot['strength']);
  }
  Stream <List<Brew>> get brews{
    return brewCollection.snapshots().map(brewlistfromsnapshot);
  }

  Stream <UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(userdatafromsnapshot);
  }
}