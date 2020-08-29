import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../ui/Pages/homePage.dart';

abstract class FirebaseAuth_Google {

  Future<User> sign();
  Future<bool> phoneLogIn(String userPhoneNumber,BuildContext context);
}

class Firebase_GoogleImp implements FirebaseAuth_Google{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =new GoogleSignIn();
  @override
  Future<User> sign() async{
   try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    User user = userCredential.user;
    print(user);
    return user;
   } catch (e) {
     throw Error();
   }
   
  }

  @override
  final _codeController = TextEditingController();
 Future<bool> phoneLogIn(String phoneNumber, BuildContext context) {
        final _auth =FirebaseAuth.instance;
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
       verificationCompleted: (AuthCredential credential) async{
          //  Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User user = result.user;

          if(user != null){
         
             Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage()
            ));
          }else{
            print("Error");
            return false;
          }

          //This callback would gets called when verification is done auto maticlly
        },
         verificationFailed: (FirebaseAuthException exception){
          print(exception);
        },
         codeSent: (String verificationId , [int forceResendingToken]){
      
                  
                    showDialog(
                    
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Color(0xff314755),
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

                      UserCredential result = await _auth.signInWithCredential(credential);

                      User user = result.user;

                      if(user != null){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomePage()
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
                 
              
               
 
         codeAutoRetrievalTimeout: (String verificationId){
           print('auto time out');
         });    
      } 
  

 // @override
  
}
