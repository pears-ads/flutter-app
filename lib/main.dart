import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_test/ui/auth/phoneLoginPage.dart';
import 'Bloc/auth/bloc/auth_bloc.dart';
import 'repository/auth/firebase_auth.dart';
import 'ui/Pages/homePage.dart';
import 'ui/auth/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}


//TODO add ios specific login firebase
//TODO add facebook login for ios

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
      create: (context) => AuthBloc(firebaseAuth_Google: Firebase_GoogleImp()),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => FirebaseAuth.instance.currentUser !=null?  HomePage() : LoginPage(),
          '/PhoneLoginPage':(context) => PhoneLoginPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Video_demo',
       // home:FirebaseAuth.instance.currentUser !=null?  HomePage() : LoginPage()  ,
      ),
    );
  }

 
}

