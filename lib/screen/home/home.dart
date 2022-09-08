import 'dart:async';
import 'package:client/apis/homeapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  static const routeName = homePageRoute;
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  bool onTask = false;
  bool onDuty = true;

Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(13.0382, 80.1565);

  final Set<Marker> _markers = {};
  final List<dynamic> _markersData = [
    {
      "lat": 13.0382,
      "lng": 80.1565,
      "title" : "Aravind S",
      "type" : "Emi"
    },
    {
      "lat": 13.0473,
      "lng": 80.0945,
      "title" : "Karthi S",
      "type" : "Loan"
    },
    {
      "lat": 13.0500,
      "lng": 80.2121,
      "title" : "Santhosh A",
      "type" : "Loan"
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

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  
    _receiveHomeScreen() async {
    return await HomeScreenAPI().getHomeScreen(context: context);
  }

  _updateStatus({required String type}) async {
    return await HomeScreenAPI().postStatus(context: context, type: type);
  }

  @override
  void initState() {
    super.initState();
    homeFutures = _receiveHomeScreen();
    print("--------calling-------");
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
    var size = sizeMedia(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: FutureBuilder(
          future: homeFutures,
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return Stack(
          children: [
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
            //buildMap(),
            dutyStatusBar(onTask: onTask,status: snapshot.data['online'] ?? false ),
            snapshot.data['online'] != true ? todayEarnings(
              statusData: snapshot.data['status_data']
            ) : assignedOrder(
              ordersData: snapshot.data['Data']
            )
          ],
        );
            }else if (snapshot.hasError) {
                    return defaultErrordialog(
                        context: context,
                        errorCode: ES_0060,
                        message: "Something went wrong.Try again Later");
                  }   return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Center(child: customCircularProgress()));
            
          },
        )
      ),
    );
  }

  /// Building Google Maps Here
  Widget buildMap() {
    var size = sizeMedia(context);
    return Container(
      color: Colors.red,
      child: Image.asset(
        "assets/images/maps.png",
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Duty Status bar which shows On/Off Duty with AssignLive Task
  Widget dutyStatusBar({required bool status,required bool onTask}) {
    var size = sizeMedia(context);
    return Container(
      margin: screenPads(context),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: onTask == true ? kIndianRed :  Colors.white,
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          onTask != true ? FlutterSwitch(
            width: 100.0,
            height: 30.0,
            valueFontSize: 14.0,
            toggleSize: 24.0,
            value: status,
            borderRadius: 30.0,
            showOnOff: true,
            activeColor: kSeaGreenColor,
            activeText: "On Duty",
            inactiveColor: kPrimaryColor,
            inactiveText: "Off Duty",
            onToggle: (val) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                   return  status != true ? singleButtonCustomDialog(
                      title: "Yah! Ready to go", context: context,
                      onPressed: (){
                        _updateStatus(type: "online");
                        setState(() {
                          onDuty = true;
                        });
                        Navigator.pop(context);
                      }, btnText: "On Duty", circularAvatarColor: kSeaGreenColor, icon: Icons.done)
                      : singleButtonCustomDialog(
                      title: "Are you sure you want to go off?", context: context,
                      onPressed: (){
                        _updateStatus(type: "offline");
                        setState(() {
                          onDuty = false;
                        });
                        Navigator.pop(context);
                      }, btnText: "Off Duty", circularAvatarColor: kIndianRed, icon: CupertinoIcons.info);
                  
                  }
                  
                  );
            },
          )
          : Text("Task has been assigned to you",style: mediumTextStyle(context).copyWith(color:Colors.white),),
          Expanded(
              child: GestureDetector(
                onTap : _onMapTypeButtonPressed,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(CupertinoIcons.map_fill, size: 18,color: onTask == true ? Colors.white : kPrimaryColor,)),
              ))
        ],
      ),
    );
  }

  /// Todays Earning Stats
  Widget todayEarnings({required Map<dynamic,dynamic> statusData}){
    var size = sizeMedia(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: screenPads(context),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        height: isMobile(context) ? 120 : 140,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Summary",style:  smallTextStyle(context).copyWith(color:kDarkSlateGray),),
            
            mediumCustomSizedBox(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customVerticalIconTitle(context: context, subtitle: statusData['total'].toString(), icon: Icons.receipt_long),
                customVerticalIconTitle(context: context, subtitle: statusData['completed'].toString(), icon: Icons.task_alt ),
                customVerticalIconTitle(context: context, subtitle: statusData['remaining'].toString(), icon: Icons.pending ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Assigned Order Details
  Widget assignedOrder({required List<dynamic> ordersData}){
    var size = sizeMedia(context);
    return GestureDetector(
      onTap: (){
        //Navigator.push(context, CustomUpPageRoute(page: OrderAcceptReachStore(),routeName: '/orderacceptreachstore'));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: screenPads(context),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          height: isMobile(context) ? 120 : 140,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Task ID : #${ordersData[0]['id']}",style:  mediumTextStyle(context).copyWith(color:kDarkSlateGray),),
              smallCustomSizedBox(context),
              kSmallDivider(context),
              smallCustomSizedBox(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                    Text("2.3 km",style: mediumTextStyle(context),),
                    Text("40 mins",style: mediumTextStyle(context)),
                    Text(ordersData[0]['completed'] == true ? "Completed" : "Pending",style:mediumTextStyle(context)),
                 ],
                 ),
                smallCustomSizedBox(context),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: kPrimaryColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("See Details",style:TextStyle(color:Colors.white)),
                    ],
                  )
                )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}