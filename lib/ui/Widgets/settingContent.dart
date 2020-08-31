
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_test/repository/auth/firebase_auth.dart';

Future<void> signOut(BuildContext context) async {
  
 final GoogleSignIn googleSignIn = new GoogleSignIn();
  googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      debugPrint('signOut');
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
}

Widget SettingContent(BuildContext context){
  return SafeArea(
            child: Center(
              child: Container(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 300.0,
                  ),
                  // Text(FirebaseAuth.instance.currentUser != null
                  //     ? '${FirebaseAuth.instance.currentUser.uid}'
                  //     : 'not loged in'),
                  SizedBox(height: 50.0),
                  FlatButton(
                    onPressed: () async{
                      signOut(context);
                   //   Firebase_GoogleImp().signOut(context);
                    //  await Firebase_GoogleImp().signOut(context);
                    //    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    },
                    child: Text(
                      'Sign out',
                      style: TextStyle(fontFamily: 'Avenir Bold'),
                    ),
                    color: Colors.redAccent,
                  ),
                ]),
               
              ),
            ),
          ); 
}