import 'package:client/helpers/headers.dart';
import 'package:client/screen/analysis/analysis.dart';
import 'package:client/screen/auth/loginpage.dart';
import 'package:client/screen/components/appscreencontroller.dart';
import 'package:client/screen/home/home.dart';
import 'package:client/screen/profile/profile.dart';
import 'package:client/screen/records/recordsindetail.dart';
import 'package:client/screen/records/recordspage.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
  }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: const AppScreenController(),
      routes: {
        AppScreenController.routeName : (context) =>  const AppScreenController(), // Path :  /appcontroller
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        AnalysisPage.routeName: (context) => const AnalysisPage(),
        RecordsPage.routeName: (context) => const RecordsPage(),
        RecordsInDetailsPage.routeName: (context) => const RecordsInDetailsPage(),
      },
    );
  }
}
