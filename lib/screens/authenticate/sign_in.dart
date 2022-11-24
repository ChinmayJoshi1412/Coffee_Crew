import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
class SignIn extends StatefulWidget {
  Function toggleview;
  SignIn(this.toggleview);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService auth = AuthService();
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: Text('Sign in to Brew Crew',
          style: TextStyle(
              color: Colors.brown[900]
          ),),
        elevation: 0,
        backgroundColor: Colors.transparent,
          actions: [
            TextButton.icon(onPressed:(){
              widget.toggleview();
            },
                icon: Icon(Icons.person),
                label:Text('Register'),
            style: TextButton.styleFrom(
              primary: Colors.brown[900]
            ),)
          ]
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30,350),
        child: Card(
        shadowColor: Colors.black,
        elevation: 40,
        color: Colors.brown[400],
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
    ),
    child: Form(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
      children: [
        SizedBox(height: 20,),
      TextFormField(
        validator: (val){
          if(val!.isEmpty) {
            return 'Enter an email';

          }
          else{
            return null;
          }
        },
        decoration: textInputDecoration.copyWith(hintText: 'Email'),
        onChanged: (val){
        setState(() {
          email = val;
        });
      },
      ),
      SizedBox(height: 20,),
      TextFormField(
        validator: (val) => val!.length<6?'Enter a password with 6+ characters':null,
        decoration: textInputDecoration.copyWith(hintText: 'password'),
        obscureText: true,
      onChanged: (val){
        setState(() {
          password = val;
        });
      },
      ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: () async{
            setState(() {
              loading = true;
            });
            dynamic result = await auth.signinwithemailandpassword(email, password);
            if(result==null)
            {
              setState(() {
                loading = false;
                error = 'could not sign in with those credentials';
              });
            }
          }, child:Text('Sign in'),
        style: ElevatedButton.styleFrom(
          primary: Colors.brown[600],
          elevation: 10,
          shadowColor: Colors.black
        ),),
        SizedBox(height: 15,),
        Text(error,style: TextStyle(color: Colors.red[700],fontSize: 14),)
      ],
      ),
    ),
    ),
    ),
    ));
  }
}
