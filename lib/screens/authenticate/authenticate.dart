import 'package:brew_crew/screens/authenticate/SignIn.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/authenticate/reg.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showsignin = true;
  void toggleview()
  {
    setState(() {
      showsignin = !showsignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showsignin)
      {
        return sign_in(toggleview);
      }
    else{
      return SignUp(toggleview);
    }
  }
}
