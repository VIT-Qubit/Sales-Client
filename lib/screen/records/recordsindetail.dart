import 'package:client/helpers/headers.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RecordsInDetailsPage extends StatefulWidget {
  static const routeName = recordsInDetailsPageRoute;
 const RecordsInDetailsPage({Key? key}) : super(key: key);

  @override
   RecordsInDetailsPageState createState() =>  RecordsInDetailsPageState();
}

class  RecordsInDetailsPageState extends State <RecordsInDetailsPage> {
 
  final bool taskBegin = false;
  final bool taskCompleted = false;

  final TextEditingController _reasonController = TextEditingController();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Map<dynamic, dynamic> _timelineData = {
    "timeline" : [
      {
      "title": "Start Task",
      "time" : "10:30 am",
    },
    {
      "title": "End Task",
      "time" : "",
    },
    ]
  };

  final List<dynamic> _measureList = [
    "Be polite to the customers",
    "Make sure to be on time"
  ];

  @override
    void initState() {
      super.initState();
    }    

  /*
  Future<void> _getAppointmentDetails() async {
    return await _appointmentsAPI.getAppointmentIndetail(context: context, appointmentId: widget.appointmentId);
  }

  Future<void> _getRefreshScreen() async {
    setState(() {
      _indetailFuture = _getAppointmentDetails();
    });
  }
  
  putCancelAppointmentBooking({required String reason}) async {
    return await _appointmentsAPI.putCancelAppointmentBooking(context: context, appointmentId: widget.appointmentId, reason: reason);
  }

  postSubmitQuery({required String title, required String description}) async {
    return await _raiseticketsAPI.postRaiseIssue(context: context, appointmentId: widget.appointmentId, title: title, description: description).then((res){
      if(res==true){
        Loader.hide();
        Navigator.of(context).pop();
      }else{
        Loader.hide();
      }
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          //await _getRefreshScreen();
        },
        color: kPrimaryColor,
        strokeWidth: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: defaultNavbar(
          context: context,
          isHelp: true,
          isBack: true,
          title: "",
          titleStyle: largeTextStyle(context),
          isElevation: true),
          body:SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kMediumDivider(context),
                //Appointment Details
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: kDefaultScreenPaddingHorizontal(context),
                      vertical: kDefaultScreenPaddingVertical(context)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#12345HSGC",style : mediumLargeTextStyle(context).copyWith(fontFamily : kMuktaBold)),
                    //if(snapshot.data['enablecancel'] == true) 
                    if(taskCompleted == false)GestureDetector(
                      onTap: () =>showDialog(
                  context: context,
                  builder: (BuildContext context) {
                   return taskBegin == false ? singleButtonCustomDialog(
                      title: "Woah! Good to go", context: context,
                      onPressed: (){
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      }, btnText: "Close", circularAvatarColor: kSeaGreenColor, icon: Icons.group)
                      :singleButtonCustomDialog(
                      title: "Excellent! Task completed", context: context,
                      onPressed: (){
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      }, btnText: "Close", circularAvatarColor: kSeaGreenColor, icon: Icons.done); 
                  }
                  ),
                      child: Text(taskBegin == false ? "Start Consultation" : "End Consultation",style : mediumLargeTextStyle(context,fontFamily : kMuktaBold).copyWith(color:taskBegin == false ? kGreenColor : kSteelBlue))),
                 ],
                ),
                smallCustomSizedBox(context),
                lineDivider(context),
                mediumCustomSizedBox(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Appointment Status",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: smallTextStyle(context).copyWith(
                            height: 1.2, color: kGraycolor, fontFamily: kMuktaBold),
                      ),
                      Text(
                         "Pending".toUpperCase(),
                        style: mediumTextStyle(context,fontFamily:kMuktaBold)
                            // .copyWith(
                            //   color: _appointments['status'] == "Pending" ? kPrimaryColor 
                            //     : (_appointments['status'] == "Completed") ? kGreenColor 
                            //     : (_appointments['status'] == "OnGoing") ? kGreenColor
                            //     : (_appointments['status'] == "Missed") ? kPinkRedishColor
                            //     : kOrangeColor,
                            //   ),
                      ),
                  ],
                ),
                mediumCustomSizedBox(context),
                ListView.builder(
                                shrinkWrap: true,
                                physics:const NeverScrollableScrollPhysics(),
                                itemCount: 3, // _appointments['details'].length,
                                itemBuilder: (BuildContext context,int i){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                    //  _appointments['details'][i]['title'] != 'Location' ? contentDescTile(
                                    //     context: context,
                                    //     title: "${_appointments['details'][i]['title']}", subtitle: "${_appointments['details'][i]['subtitle']}")
                                    //     :
                                         Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Location / Type / Directions",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    softWrap: true,
                                                    style: smallTextStyle(context).copyWith(
                                                        height: 1.2, color: kGraycolor, fontFamily: kMuktaBold),
                                                  ),
                                                  Text(
                                                    "Open Url",
                                                    style: mediumTextStyle(context)
                                                        .copyWith(color: kPrimaryColor,fontFamily:kMuktaBold),
                                                  ),
                                                ],
                                              ),
                                      mediumCustomSizedBox(context),
                                      ],
                                    );
                                }
                              ),
                smallCustomSizedBox(context),  
                    GestureDetector(
                      onTap: () =>  bottomDialog(
                                        context: context,
                                        height: 380,
                                        widget: Container(
                                          margin: screenPads(context),
                                          child: ListView(
                                            children: [
                                               Text("Submit your query to get help from us",
                                softWrap: true,
                                style: mediumTextStyle(context).copyWith(fontFamily: kMuktaRegular,height:1.1)),
                                mediumCustomSizedBox(context),
                                Container(
                        //height: 50,
                        decoration: BoxDecoration(
                          color: kLightLavengerGrayColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:TextFormField(
                controller: _subjectController,
               keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 2,
                enableSuggestions: true,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  enabled: true,
                  hintText: 'Subject',
                  hintStyle: const TextStyle(
                    color: kGraycolor,
                    fontSize: 13.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kGraycolor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: kGraycolor),
                  ),
                ),
                // maxLength: 10,
                ),  
                        ),
                                mediumCustomSizedBox(context),
                                Container(
                        //height: 50,
                        decoration: BoxDecoration(
                          color: kLightLavengerGrayColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:TextFormField(
                controller: _descriptionController,
               keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: 7,
                enableSuggestions: true,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  enabled: true,
                  hintText: 'Your query',
                  hintStyle: const TextStyle(
                    color: kGraycolor,
                    fontSize: 13.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kGraycolor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: kGraycolor),
                  ),
                ),
                // maxLength: 10,
                ),  
                        ),
                                
                                 mediumCustomSizedBox(context),
                                              GestureDetector(
                                                onTap: () {
                                                  // if(_subjectController.text.isEmpty){
                                                  //   ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter the subject"));
                                                  // }else if(_descriptionController.text.isEmpty){
                                                  //   ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter the description"));
                                                  // }else{
                                                  //   overlayLoader(context);
                                                  //   postSubmitQuery(title: _subjectController.text.trim(), description: _descriptionController.text.trim());
                                                  // }
                                                },
                                                child: Container(
                                                  height: 35, 
                                                  margin:EdgeInsets.symmetric(horizontal: kDefaultScreenPaddingHorizontal(context) * 2,vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color : kPinkRedishColor,
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  child: Center(
                                                    child:  Text("Submit Query".toUpperCase(),style: mediumTextStyle(context).copyWith(color:Colors.white))
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                      child: Text("Help?",style : mediumLargeTextStyle(context).copyWith(fontFamily : kMuktaBold,color:kSteelBlue))),  
                lineDivider(context),
                smallCustomSizedBox(context),
                 Text(" *Tap on Help to get support from us",
                                softWrap: true,
                                style: smallTextStyle(context).copyWith(fontFamily: kMuktaRegular,color:kIndigocolor,height:1.1))
                    ],
                  ),
                ),  
                kMediumDivider(context),
                _orderStatus(
                  isCancelled: true,//,_appointments['timeline']['cancelled'],
                  timeline: {}, //_timelineData['timeline'], //,_appointments['timeline'],
                ),
                kMediumDivider(context),
                Container(
                   margin: EdgeInsets.symmetric(
                      horizontal: kDefaultScreenPaddingHorizontal(context),
                      vertical: kDefaultScreenPaddingVertical(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      smallCustomSizedBox(context),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              maxRadius: isMobile(context) ? 25 : 35,
                              backgroundImage: const AssetImage(DEFAULT_AVATAR_IMG)),
                          RotatedBox(
                            quarterTurns: 1,
                            child: mediumCustomSizedBox(context),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               
                                Text(
                        "A.Sundaram",
                        maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                        style: mediumTextStyle(context)
                            .copyWith(color: Colors.black.withOpacity(0.9),fontFamily:kMuktaBold),
                      ),
                                Text(
                                  "8012345678",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: smallTextStyle(context).copyWith(
                                      height: 1.2,
                                      color: Colors.black.withOpacity(0.9)),
                                ),
                                smallCustomSizedBox(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),              
                kSmallDivider(context),
                measuresTakenList(context: context,measuresList: _measureList,),
                mediumCustomSizedBox(context),
                kSmallDivider(context),
                //Add cancel button here
                GestureDetector(
                  onTap: () => bottomDialog(
                                        context: context,
                                        height: 300,
                                        widget: Container(
                                          margin: screenPads(context),
                                          child: ListView(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                               Text("Please enter a reason to cancel this task",
                                softWrap: true,
                                style: mediumTextStyle(context,fontFamily: kMuktaRegular)),
                                mediumCustomSizedBox(context),
                                Container(
                        //height: 50,
                        decoration: BoxDecoration(
                          color: kLightLavengerGrayColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:TextFormField(
                controller: _reasonController,
               keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: 7,
                enableSuggestions: true,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  enabled: true,
                  hintText: 'Your reason',
                  hintStyle: const TextStyle(
                    color: kGraycolor,
                    fontSize: 13.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kGraycolor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: kGraycolor),
                  ),
                ),
                // maxLength: 10,
                ),  
                        ),
                      mediumCustomSizedBox(context),
                                              GestureDetector(
                                                onTap: () {
                                                  // if(_reasonController.text.isNotEmpty){
                                                  //   overlayLoader(context);
                                                  //   putCancelAppointmentBooking(reason: _reasonController.text.trim());
                                                    
                                                  // }else{
                                                  //   ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter a valid reason to cancel this appointment"));
                                                  // }
                                                },
                                                child: Container(
                                                  height: 35, 
                                                  margin:EdgeInsets.symmetric(horizontal: kDefaultScreenPaddingHorizontal(context) * 2,vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color : kPinkRedishColor,
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  child: Center(
                                                    child:  Text("Send Cancel Request".toUpperCase(),style: mediumTextStyle(context).copyWith(color:Colors.white))
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                  child: Container(
                    height: 40,
                                       margin: EdgeInsets.symmetric(
                        horizontal: kDefaultScreenPaddingHorizontal(context),
                        vertical: kDefaultScreenPaddingVertical(context)),
                    decoration: BoxDecoration(
                      color: kRedColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("CANCEL",style:TextStyle(color:Colors.white)),
                      ],
                    )
                  ),
                ),
                mediumCustomSizedBox(context),
       ],
            ),
          ),
          /* 
          FutureBuilder(
            future: _indetailFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                Map<dynamic, dynamic> _appointments = snapshot.data;
                return 
              }else if (snapshot.hasError) {
                    return defaultErrordialog(
                        context: context,
                        errorCode: ES_0060,
                        message: "Something went wrong.Try again Later");
                  }
                  return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Center(child: customCircularProgress()));
            },
          ) */
        ),
      ) ,
    );
  }

  Widget _orderStatus({required bool isCancelled,required Map<dynamic,dynamic> timeline }) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultScreenPaddingHorizontal(context),),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          contentDescTile(context: context, subtitle: "Task Timline", title: ""),
          mediumCustomSizedBox(context),
          
          _stepperWidget(title: "Start Task", time: "10:30am", isCancelled: false, isLast: false, completed: true),
          _stepperWidget(title: "End Task", time: "", isCancelled: false, isLast: true, completed: false),

          // _stepperWidget(isDone: true,isCancelled : false, isProcessing: false, title: "${timeline['step1']['title']}",time: "${timeline['step1']['time']}"),
        //  if(isCancelled == false) _stepperWidget(
        //    isCancelled : false,
        //    isDone: timeline['step2']['completed'], 
        //    isProcessing: (timeline['step2']['completed'] == true) ? false : true, 
        //    title: "${timeline['step2']['title']}",time:  "${timeline['step2']['time']}"),
        //  if(isCancelled == false) _stepperWidget(
        //    isCancelled : false,
        //    isDone: timeline['step3']['completed'],
        //    isProcessing: (timeline['step2']['completed'] == true) ?(timeline['step3']['completed'] == true ? false : true) :  false, 
        //    title: "${timeline['step3']['title']}",
        //    time: "${timeline['step3']['time']}",isLast: true),
        //  if(isCancelled == true)  _stepperWidget(
        //    isCancelled : true,
        //    isDone:false,isProcessing: false, title: "${timeline['cancel']['title']}",time: "${timeline['cancel']['time']}",isLast: true),
        ],
      ),
    );
  }

    Widget _stepperWidget({required String title,required String time,required bool isCancelled,required bool isLast,required bool completed}){
    return SizedBox(
              height: 60,
              child: TimelineTile(
                  beforeLineStyle: LineStyle(color: completed == true ? Colors.black : kTertiaryColor,thickness:0.6 ),
                  indicatorStyle: IndicatorStyle(
                    color: kMediumSeaGreen,
                    drawGap: true,
                    height: 25,
                    width: 25,
                    indicatorXY: 0,
                    indicator: Container(
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: completed == true  ? kMediumSeaGreen : kLavenderGrayColor,
                      ),
                      child:  Center(
                        child: Icon(
                          (completed == true) ? Icons.done : Icons.trip_origin_outlined, 
                          size: 16, color:Colors.white),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                  ),
                  alignment: TimelineAlign.start,
                  isFirst: true,
                  isLast: isLast == true ?  true : false,
                  endChild: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
                      constraints: const BoxConstraints(minHeight: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: smallTextStyle(context,fontFamily: kRobotoMedium).copyWith(color: completed ==true ? kPrimaryColor : kLavenderGrayColor )
                          ),
                          Text(
                           isEmptyOrNull(time) ? "-" : time,
                            style: smallTextStyle(context,fontFamily: kRobotoMedium).copyWith(color: completed ==true ? kPrimaryColor : kLavenderGrayColor ,fontSize: isMobile(context) ? 11.5 : 13.5),
                          ),
                          mediumCustomSizedBox(context),
                          const Divider(color: kTertiaryColor, height: 0.5)
                        ],
                      ))),
            );
       
  }

}