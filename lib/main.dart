import 'dart:async';

import 'package:client/helpers/headers.dart';
import 'package:client/screen/analysis/analysis.dart';
import 'package:client/screen/auth/loginpage.dart';
import 'package:client/screen/components/appscreencontroller.dart';
import 'package:client/screen/home/home.dart';
import 'package:client/screen/profile/profile.dart';
import 'package:client/screen/profile/referral.dart';
import 'package:client/screen/records/recordsindetail.dart';
import 'package:client/screen/records/recordspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
      home: const AppScreenController(),
      routes: {
        AppScreenController.routeName: (context) =>
            const AppScreenController(), // Path :  /appcontroller
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        AnalysisPage.routeName: (context) => const AnalysisPage(),
        RecordsPage.routeName: (context) => const RecordsPage(),
        RecordsInDetailsPage.routeName: (context) =>
            const RecordsInDetailsPage(),
        ReferralCode.routeName: (context) => const ReferralCode(),
      },
    );
  }
}

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};
  final List<dynamic> _markersData = [
    {
      "lat": 45.521563,
      "lng": -122.677433,
      "title" : "Aravind S",
      "type" : "Emi"
    },
  ];

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      print(_markers);
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  
  @override
  void initState() {
    for (var i = 0; i < _markersData.length; i++) {
      print("======================");
      print(_markersData[i]);
         _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: LatLng(_markersData[i]['lat'], _markersData[i]['lng']),
        infoWindow: InfoWindow(
          title: _markersData[i]['title'],
          snippet: _markersData[i]['type'],
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
  }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
           Container(
      margin: screenPads(context),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kIndianRed
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           FlutterSwitch(
            width: 100.0,
            height: 30.0,
            valueFontSize: 14.0,
            toggleSize: 24.0,
            value: true,
            borderRadius: 30.0,
            showOnOff: true,
            activeColor: kSeaGreenColor,
            activeText: "On Duty",
            inactiveColor: kPrimaryColor,
            inactiveText: "Off Duty",
            onToggle: (val) {
            },
          ),Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(CupertinoIcons.bell_fill, size: 18,color: kPrimaryColor,)))
        ],
      ),
    )
          ],
        ),
      ),
    );
  }
}
