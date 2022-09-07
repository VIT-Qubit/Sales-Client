/*-----------------App Controller is the bottomNavigationBar controller--------------------------*/

import 'package:client/screen/analysis/analysis.dart';
import 'package:client/screen/home/home.dart';
import 'package:client/screen/profile/profile.dart';
import 'package:client/screen/records/recordspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/helpers/headers.dart';

class AppScreenController extends StatefulWidget {
  //Named route Path
  static const routeName = appControllerRoute;

  const AppScreenController({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AppScreenController> {
  
  //Scroll Controller variable
  late ScrollController bottombarController;

  @override
  void initState() {
  super.initState();
  bottombarController = ScrollController();
  }  

  @override
  void dispose() {
    bottombarController.dispose();
    super.dispose();
  }

//This is invoked when user taps on bottom icons in bar 
void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  //initializing the current index = 0 : HomePage
  int _currentIndex = 3;

  //Current Index with Widget paths
  final List<Widget> _children = [
      HomePage(),
      RecordsPage(),
      AnalysisPage(),
      ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    //Icons size 
    double sizeIcon = smallMobile(context) ? 9 : largeMobile(context) ? 10 : isBetweenMT2(context) ? 10 : isBetweenMT1(context) ? 11 : 13;
    return Scaffold(
      backgroundColor: Colors.white,
     
      bottomNavigationBar:  BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            selectedFontSize: sizeIcon,
            unselectedFontSize: sizeIcon,
            unselectedItemColor: kLightGrayColor,
            selectedItemColor: kPrimaryColor,
            selectedLabelStyle: TextStyle(color: kPrimaryColor,fontFamily: "RobotoMedium"),
            unselectedLabelStyle: TextStyle(color: kPrimaryColor,fontFamily: "RobotoMedium"),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            
            onTap: onTabTapped, 
         items: const [
            BottomNavigationBarItem(
             icon: Icon(Icons.explore_outlined),
             label: "Home",
           ),
            BottomNavigationBarItem(
             icon: Icon(Icons.checklist_rounded),
            label: "Records",
           ),
            BottomNavigationBarItem(
             icon: Icon(Icons.analytics_outlined),
             label: "Analytics"
           ),
            BottomNavigationBarItem(
             icon: Icon(CupertinoIcons.person_alt),
             label: "Profile"
           )
         ],
          ),
        body : SafeArea(
          //Returning the widget here
          child: _children[_currentIndex]
          )

    );
  }
}