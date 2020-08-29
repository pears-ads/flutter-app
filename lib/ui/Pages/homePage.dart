import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/loginPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    void signOut() async {
      googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    //  debugPrint('signOut');
     Navigator.push(context, MaterialPageRoute(builder: (context){
       return LoginPage();
     }));
      
    }

    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          await SystemChannels.platform
              .invokeMethod<void>('SystemNavigator.pop');
        },
        child: Scaffold(
            body:SafeArea(

                          child: Center(

                            child: Container(
                              child: Column(
                                children:<Widget>[
                                  SizedBox(height: 300.0,),
                                  Text( FirebaseAuth.instance.currentUser!=null ? 'loged in':'not loged in'),
                                  SizedBox(height:50.0),
                                  FlatButton(onPressed: (){signOut();}, child: Text('Sign out' ,style: TextStyle(fontFamily: 'Avenir Bold'),) , color: Colors.redAccent,),
                                ]
                              ),
               // child: Text('hello'),
               // child: SvgPicture.string( 'lib\assets\svgs\login_background.svg',height: 100,),
              ),
                          ),
            ),
            
            ));
  }
}
