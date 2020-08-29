import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
      create: (context) => AuthBloc(firebaseAuth_Google: Firebase_GoogleImp()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video_demo',
        home:FirebaseAuth.instance.currentUser !=null?  HomePage() : LoginPage()  ,
      ),
    );
  }

 
}

