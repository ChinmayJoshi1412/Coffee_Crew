import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
class AuthService{
  final FirebaseAuth auth = FirebaseAuth.instance;
  //create user object based on firebase user
  FirebaseUser? userfromfirebaseuser(User? user){
        return user != null ? FirebaseUser(user.uid) : null;
  }

  Stream<FirebaseUser?> get user{
    return auth.authStateChanges().map(userfromfirebaseuser);
  }
  Future signinanon() async{
    try{
        UserCredential result = await auth.signInAnonymously();
        User _user = result.user!;
        return userfromfirebaseuser(_user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signinwithemailandpassword(String email,String password) async
  {
    try{
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return user;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerwithemailandpassword(String email,String password) async
  {
    try{
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      //create a new document for the user
      await DatabaseService(user.uid.toString()).updateUserData('0', 'new member', 100);
      return userfromfirebaseuser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign out
  Future signout() async{
    try{
      return await auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}