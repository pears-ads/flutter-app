//this is login Page

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_test/Bloc/auth/bloc/auth_bloc.dart';
import 'package:video_test/ui/Pages/homePage.dart';
import 'package:video_test/ui/auth/phoneLoginPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    // add push name and rout
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        } else if (state is AuthErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('error occure'),
          ));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthInitial) {
          return initialLoginWidget(context, height);
        } else if (state is AuthErrorState) {
          return initialLoginWidget(context, height);
        }
      }),
    ));
  }

  Widget initialLoginWidget(BuildContext context, double height) {
 
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            
              image: AssetImage("lib/assets/background.jfif",),
              //colorFilter: ColorFilter.mode(Colors.white24.withOpacity(0.8),BlendMode.dstATop ),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height * 0.002,
            ),
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: height * 0.08,
                        backgroundImage: AssetImage('lib/assets/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Center(
                      child: Container(
                          child: Text('PEARS',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white))),
                    ), //0xff8ed9e5
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "Opportunity",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          color:Color(0xff26A0DA)),
                    ),
                    SizedBox(width: 10.0)
                  ]),
                ),
                SizedBox(width: 10.0,),
                Text('when you need it' ,style: TextStyle(color:Colors.white ,fontWeight:FontWeight.w800 , fontSize:20.0),)
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        loginWithGoogle(context);
                      },
                      //color:Color(0xffe21f32),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.network(
                                  'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
                                  height: height * 0.05),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(fontSize: 20),
                              )
                            ]),
                      )),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                      color: Colors.white,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                  'lib/assets/facebook_login_icon.png',
                                  height: height * 0.05),
                              Text(
                                'Sign in with FaceBook',
                                style: TextStyle(fontSize: 20),
                              )
                            ]),
                      )),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return PhoneLoginPage();
                        }) );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                  'lib/assets/phone_login_icon.png',
                                  height: height * 0.05),
                              Text(
                                'Sign in with Mobile',
                                style: TextStyle(fontSize: 20),
                              )
                            ]),
                      )),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  // CALLING BLOC FOR GOOGLE LOGIN
  void loginWithGoogle(BuildContext context) {
    debugPrint('statement');
    final authBloc = context.bloc<AuthBloc>();
    authBloc.add(SignInWithGoogle());
  }
}

/*

 * 
 *  Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(style: TextStyle(color:Colors.white),
                            controller: phoneNumberController,
                            // keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color:Colors.white),
                           
                               enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white),   
                                ),  
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                            ),
                          ),
                        ),
                        SizedBox(height:height*0.05),
                        FlatButton(onPressed: () {
                           
                         Firebase_GoogleImp().phoneLogIn(phoneNumberController.text.trim(), context);
                        
                        } ,child: Text('Login',style: TextStyle(color:Colors.black),) ,color: Colors.white,)
 * 
 */
