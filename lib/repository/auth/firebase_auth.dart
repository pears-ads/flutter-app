import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../ui/Pages/homePage.dart';

abstract class FirebaseAuth_Google {

  Future<User> sign();
  Future<bool> phoneLogIn(String userPhoneNumber,BuildContext context);   
 // void signOut(BuildContext context);
  Future<User> signInWithFacebook();              
}

class Firebase_GoogleImp implements FirebaseAuth_Google{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =new GoogleSignIn();

  // @override
  // void signOut(BuildContext context) async{
  //   googleSignIn.signOut();
  //    await FirebaseAuth.instance.signOut();
  //     debugPrint('signOut');
  //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  // }


  @override
  Future<User> sign() async{
   try {
    final GoogleSignInAccount googleSignInAccount =  await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    User user = userCredential.user;
    print(user);
    return user;
   } on PlatformException catch(err) {
      if (err.code == 'sign_in_canceled') { // Checks for sign_in_canceled exception
      print(err.toString());
      } else {
        throw err; // Throws PlatformException again because it wasn't the one we wanted
      }
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
                title: Text("Enter OTP"  ,style: TextStyle(fontFamily:'Avenir')),
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
                    child: Text("Confirm" ,style: TextStyle(fontFamily:'Avenir'),),
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

  //facebook sign in
  @override
  Future<User> signInWithFacebook() async{
  try {
     final facebookLogin = FacebookLogin();
   final result = await facebookLogin.logIn(['public_profile']);
    if(result.accessToken != null){
      final authResult = await _auth.signInWithCredential(
        FacebookAuthProvider.credential(
          result.accessToken.token
        )
      );
     UserCredential userCredential = await _auth.signInWithCredential(authResult.credential);
    User user = userCredential.user;
      return user ;
    }
  } catch (err) {
    throw err;
  }
    
  }


}
