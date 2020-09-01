import 'package:flutter/material.dart';

Widget HomeContent() {
  return Column(
    children: <Widget>[
      SizedBox(height: 10.0,),
      Center(child: Container(child:Text('Select ads from one platform'))),
      cardView('lib/assets/google_login_icon.png'),
      cardView('lib/assets/facebook_login_icon.png'),
      cardView('lib/assets/facebook_login_icon.png'),
    ],
  );

}

 Widget cardView(String imageSrc){
   return  Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Stack(
            children: <Widget>[
              //card
               Container(
                height: 124.0,
                margin: EdgeInsets.only(left: 46.0),
                decoration:  BoxDecoration(
                  color:  Color(0xff314755),
                  shape: BoxShape.rectangle,
                  borderRadius:  BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                     BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
              ),

              //thumbnail
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                alignment: FractionalOffset.centerLeft,
                child: Image(
                  image: AssetImage(imageSrc),
                  height: 92.0,
                  width: 92.0,
                ),
              ),
            ],
          ));

  }