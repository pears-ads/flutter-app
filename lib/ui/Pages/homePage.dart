import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Widgets/homeContent.dart';
import '../Widgets/settingContent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
 Widget _childContainer;
  @override
  void initState() {
    _childContainer = HomeContent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    void signOut() async {
      googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      debugPrint('signOut');
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }

    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          await SystemChannels.platform
              .invokeMethod<void>('SystemNavigator.pop');
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff314755),
            title:Text('Pears',style: TextStyle(fontFamily:'Avenir Bold'),)
          ),
          body: _childContainer,
          bottomNavigationBar: FluidNavBar(
          onChange: _handleNavigationChange,
          icons: [
            FluidNavBarIcon(iconPath: 'lib/assets/svg/home_icon.svg'),
            FluidNavBarIcon(iconPath: 'lib/assets/svg/settings_icon.svg')
          ],
          style: FluidNavBarStyle(
          barBackgroundColor: Color(0xff26A0DA),
          iconBackgroundColor: Colors.white,
          iconSelectedForegroundColor: Color(0xff26A0DA),
          iconUnselectedForegroundColor: Colors.black
          ),
          animationFactor: 1.0,
          ),

          
        )
        
        );
  }

  void _handleNavigationChange(int index){
     setState(() {
      switch (index) {
        case 0:
          _childContainer = HomeContent();
          break;
        case 1:
          _childContainer = SettingContent(context);
          break;
       
      }
      _childContainer = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _childContainer,
      );
    });
  }
}
