import 'package:client/helpers/headers.dart';
import 'package:client/screen/analysis/analysis.dart';
import 'package:client/screen/auth/loginpage.dart';
import 'package:client/screen/components/appscreencontroller.dart';
import 'package:client/screen/home/home.dart';
import 'package:client/screen/profile/profile.dart';
import 'package:client/screen/profile/referral.dart';
import 'package:client/screen/records/recordsindetail.dart';
import 'package:client/screen/records/recordspage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
      home: const MapsPage(),
      routes: {
        AppScreenController.routeName : (context) =>  const AppScreenController(), // Path :  /appcontroller
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        AnalysisPage.routeName: (context) => const AnalysisPage(),
        RecordsPage.routeName: (context) => const RecordsPage(),
        RecordsInDetailsPage.routeName: (context) => const RecordsInDetailsPage(),
        ReferralCode.routeName: (context) => const ReferralCode(),
      },
    );
  }
}

class MapsPage extends StatefulWidget {
  const MapsPage({ Key? key }) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
    late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      );
  }
}
