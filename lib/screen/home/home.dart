import 'package:client/helpers/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  static const routeName = homePageRoute;
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool onTask = false;
  bool onDuty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          buildMap(),
          dutyStatusBar(onTask: onTask,status: onDuty ),
          onTask != true ? todayEarnings() : assignedOrder()
        ],
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
                        setState(() {
                          onDuty = true;
                        });
                        Navigator.pop(context);
                      }, btnText: "On Duty", circularAvatarColor: kSeaGreenColor, icon: Icons.done)
                      : singleButtonCustomDialog(
                      title: "Are you sure you want to go off?", context: context,
                      onPressed: (){
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
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(CupertinoIcons.bell_fill, size: 18,color: onTask == true ? Colors.white : kPrimaryColor,)))
        ],
      ),
    );
  }

  /// Todays Earning Stats
  Widget todayEarnings(){
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
                customVerticalIconTitle(context: context, subtitle: "10", icon: Icons.receipt_long),
                customVerticalIconTitle(context: context, subtitle: "4", icon: Icons.task_alt ),
                customVerticalIconTitle(context: context, subtitle: "6", icon: Icons.pending ),
                
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Assigned Order Details
  Widget assignedOrder(){
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
              Text("Task ID : #12345678901",style:  mediumTextStyle(context).copyWith(color:kDarkSlateGray),),
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
                    Text("Pending",style:mediumTextStyle(context)),
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