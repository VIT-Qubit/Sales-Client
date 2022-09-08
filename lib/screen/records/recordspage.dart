import 'package:client/apis/liveapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screen/components/navbar.dart';
import 'package:client/screen/records/recordsindetail.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RecordsPage extends StatefulWidget {
  static const routeName = recordsPageRoute;
  const RecordsPage({Key? key}) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

 final LiveScreenAPI _liveAPI = LiveScreenAPI();

  @override
  void initState() {
    super.initState();
    recordsFuture = getRecordScreen();
  }

  getRecordScreen() async{
    return await _liveAPI.getLiveScreen(context: context);
  }

  Future<void> _getRefreshedScreen() async {
    setState(() {
    recordsFuture = getRecordScreen();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultNavbar(
          context: context,
          isHelp: false,
          isBack: false,
          title: "Live Jobs",
          titleStyle: largeTextStyle(context),
          isElevation: true),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getRefreshedScreen,
          child: FutureBuilder(
            future: recordsFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                              List<dynamic> _taskData = snapshot.data['Data'];
              Map<dynamic, dynamic> _statusData = snapshot.data['status_data'];
              double pendingSteps = (_statusData['completed']/_statusData['total'])*100; 
                return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Your Target
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        containerTitleBar(context: context, title: "Your Target"),
                        
                        Container(
                            padding: screenPads(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                target(
                                  context: context,
                                    title: "Tasks Available",
                                    subtitle: "Complete all your tasks available for today",
                                    completedtask: _statusData['total'].toString(),
                                    totaltask: _statusData['remaining'].toString(),
                                    totalSteps: 100,
                                    currentStep: pendingSteps.toInt()),
                                mediumCustomSizedBox(context),
                              ],
                            )),
                        
                      ],
                    ),
                  ),


                  /// Todays 
                  Container(
                    child: Column(
                      children: [
                        containerTitleBar(
                            context: context, title: "Today's Task"),
                        Container(
                          padding: screenPads(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              smallCustomSizedBox(context),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: cardsBox(context:context,
                                          title: "Total Task",
                                          subtitle: _statusData['total'].toString())),
                                  RotatedBox(
                                      quarterTurns: 1,
                                      child: smallCustomSizedBox(context)),
                                  Expanded(
                                      child: cardsBox(context:context,
                                          title: "Completed Task",
                                          subtitle: _statusData['completed'].toString())),
                                ],
                              ),
                              mediumCustomSizedBox(context),Container(
              margin: screenPads(context),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 mediumCustomSizedBox(context),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _taskData.length,//_recordList.length,
                    itemBuilder: (BuildContext context, int i){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, CustomRightPageRoute(page : RecordsInDetailsPage(
                            ticket_id: _taskData[i]['id'].toString(),
                          ),routeName: recordsInDetailsPageRoute));
                        },
                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                        boxShadow:const [
                          BoxShadow(
                            color: kSlateGray,
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: Offset(0,0), // changes position of shadow
                          ),
                        ]
                        //border: Border.all(color:kDimGray)
                                          ),
                                          child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Task ID : #${_taskData[i]['id']}",style: mediumTextStyle(context).copyWith(fontFamily : kMuktaBold,letterSpacing: 0.2,color:Colors.black.withOpacity(0.8))),
                                Text("${_taskData[i]['customer_id']['name']}",
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: mediumTextStyle(context).copyWith(letterSpacing: 0.1,color:kPrimaryColor)),
                                Text("${_taskData[i]['ticket_type']}",style:smallTextStyle(context)),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_right_alt_outlined,color: kPrimaryColor,size: isMobile(context) ? 25 : 35)
                          ]
                        ),
                        smallCustomSizedBox(context), 
                        ],
                                        ),
                                        ),
                      );
                    },
                  ),
                ],
              )
            )
                          ],
                          ),
                        ),
                      ],
                    ),
                  ),

                
                ],
              ),
            ),
          );
              }else if (snapshot.hasError) {
                    return defaultErrordialog(
                        context: context,
                        errorCode: ES_0060,
                        message: "Something went wrong.Try again Later");
                  }   return SizedBox(
                      width: sizeMedia(context).width,
                      height: sizeMedia(context).height,
                      child: Center(child: customCircularProgress()));
         
            },
          )
        ),
      ),
    );
  }
}



  Widget cardsBox({required BuildContext context,required String title, required String subtitle}) {
    double conHeight = smallMobile(context)
        ? 125
        : largeMobile(context)
            ? 125
            : 140;
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        height: conHeight,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: kLavenderGrayColor, width: 1.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: mediumLargeTextStyle(context)),
            smallCustomSizedBox(context),
            Text(
              subtitle,
              softWrap: true,
              style: TextStyle(
                  color: kIndianRed,
                  fontFamily: kRobotoBold,
                  fontSize: isMobile(context) ? 26 : 30),
            ),
            // smallCustomSizedBox(context),
            // Text("View Details",
            //     style: smallTextStyle(context).copyWith(color: kSteelBlue)),
          ],
        ),
      ),
    );
  }

  Widget target(
      {
      required BuildContext context,  
      required String title,
      required String subtitle,
      required String totaltask,
      required String completedtask,
      required int totalSteps,
      required int currentStep}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          underlineTitleText(
            context: context,
            lineColor: kPrimaryColor,
            textColor: kPrimaryColor,
            text: title,
          ),
          smallCustomSizedBox(context),
          Wrap(
            children: [
              Text(subtitle,
                  style: smallTextStyle(context).copyWith(color: kPrimaryColor))
            ],
          ),
          mediumCustomSizedBox(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "",
                style: smallTextStyle(context),
              ),
              Text("$completedtask/$totaltask", style: smallTextStyle(context))
            ],
          ),
          StepProgressIndicator(
            totalSteps: totalSteps,
            currentStep: currentStep,
            size: 8,
            padding: 0,
            selectedColor: kGreenColor,
            unselectedColor: kLavenderGrayColor,
            roundedEdges: Radius.circular(10),
            selectedSize: 10,
            unselectedSize: 6,
          ),
        ],
      ),
    );
  }
  