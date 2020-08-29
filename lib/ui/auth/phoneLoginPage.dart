import 'package:flutter/material.dart';

import '../../repository/auth/firebase_auth.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({Key key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
     TextEditingController phoneNumberController = TextEditingController();
     final height =  MediaQuery.of(context).size.height;
    // final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title:Text('Sign in with Phone'),
        backgroundColor: Color(0xff314755),  //(0xff26A0DA
      ),

      body:  Column(
        children: [
           SizedBox(height:height*0.05),
                          
          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(style: TextStyle(color:Colors.black),
                                controller: phoneNumberController,
                                // keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  
                                  //errorText: phoneNumberController.text.trim() != '' ? null :"please enter phone Number with +91 or your country code",
                                hintText: 'Phone Number with country code +91',
                                
                                hintStyle: TextStyle(color:Colors.black),
                               
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(20.0)),      
                                      borderSide: BorderSide(color: Color(0xff314755)),   
                                    ),  
                                    focusedBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(20.0)),      
                                      borderSide: BorderSide(color: Color(0xff26A0DA)),   
                                    ),  
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height:height*0.05),
                          
                        FlatButton(onPressed: () {
                        if(phoneNumberController.text.trim() == '' && phoneNumberController.text.trim().length != 10){
                         debugPrint('this is not valid');
                        //  final snackBar = SnackBar(content: Text('please enter valid Phone number !!!'));
                        //   _scaffoldKey.currentState.showSnackBar(snackBar); 
                        }
                        else{
                           Firebase_GoogleImp().phoneLogIn(phoneNumberController.text.trim(), context);
                        }
                        
                        } ,child: Text('Login',style: TextStyle(color:Colors.white),) ,color: Color(0xff314755),)
        ],
      ),
                        


    );
  }
}