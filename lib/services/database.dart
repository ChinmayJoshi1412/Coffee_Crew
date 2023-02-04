import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
class DatabaseService{
  final String uid;
  DatabaseService(this.uid);
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strength,String note,int tilecolor) async
  {
    return await brewCollection.doc(uid).set({
    'sugars' : sugars,
      'name' : name,
      'strength' : strength,
      'note': note,
      'tilecolor':tilecolor,
    });
  }
  List<Brew> brewlistfromsnapshot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return Brew(
          doc['name'] ?? '',
          doc['strength'] ?? 0,
          doc['sugars']??'0',
          doc['note']??'',
          doc['tilecolor']??0);
    }).toList();
  }

  UserData userdatafromsnapshot(DocumentSnapshot snapshot)
  {
    return UserData(uid, snapshot['name'], snapshot['sugars'],snapshot['strength'],snapshot['note'],snapshot['tilecolor']);
  }
  Stream <List<Brew>> get brews{
    return brewCollection.snapshots().map(brewlistfromsnapshot);
  }

  Stream <UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(userdatafromsnapshot);
  }
}