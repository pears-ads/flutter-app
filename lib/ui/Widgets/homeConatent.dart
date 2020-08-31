import 'package:flutter/material.dart';

Widget HomeContent(){
  return SafeArea(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Google ads'),
                
              );
             },
            ),
          );
}