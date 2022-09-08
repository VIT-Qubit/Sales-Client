import 'package:client/apis/recordsindetailapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RecordsInDetailsPage extends StatefulWidget {
  static const routeName = recordsInDetailsPageRoute;

  final String ticket_id;

 const RecordsInDetailsPage({Key? key,required this.ticket_id}) : super(key: key);

  @override
   RecordsInDetailsPageState createState() =>  RecordsInDetailsPageState();
}

class  RecordsInDetailsPageState extends State <RecordsInDetailsPage> {
 
  RecordsInDetailAPI _inDetailAPI = new RecordsInDetailAPI();

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
      recordsInDetailFuture = getRecordsData();
    }    



startConsultation()async {
  return await _inDetailAPI.postStatusConsultation(context: context, type: "START", ticket_id: this.widget.ticket_id);
}

endConsultation()async {
  return await _inDetailAPI.postStatusConsultation(context: context, type: "END", ticket_id: this.widget.ticket_id);
}

  getRecordsData() async {
    return await _inDetailAPI.getIndetailScreen(context: context, ticket_id: this.widget.ticket_id);
  }

  Future<void> _getRefreshedScreen() async {
    setState(() {
      recordsInDetailFuture = getRecordsData();
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _getRefreshedScreen,
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
          body:
          FutureBuilder(
            future: recordsInDetailFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                print("----------------------------------------------");
                print(snapshot.data['data']['started'].runtimeType);
                return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kMediumDivider(context),
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
                    Text("#${snapshot.data['data']['id']}",style : mediumLargeTextStyle(context).copyWith(fontFamily : kMuktaBold)),
                    //if(snapshot.data['enablecancel'] == true) 
                    if(snapshot.data['data']['completed'] == false)GestureDetector(
                      onTap: () =>showDialog(
                  context: context,
                  builder: (BuildContext context) {
                   return snapshot.data['data']['started'] == false ? singleButtonCustomDialog(
                      title: "Woah! Good to go", context: context,
                      onPressed: ()async{
                        startConsultation();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, btnText: "Close", circularAvatarColor: kSeaGreenColor, icon: Icons.group)
                      :singleButtonCustomDialog(
                      title: "Excellent! Task completed", context: context,
                      onPressed: ()async{
                        endConsultation();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, btnText: "Close", circularAvatarColor: kSeaGreenColor, icon: Icons.done); 
                  }
                  ),
                      child: Text( 
                        (snapshot.data['data']['completed'] == true) ? "" : (snapshot.data['data']['started'] == true) ? "End Consultation" : "Start Consultation",style : mediumLargeTextStyle(context,fontFamily : kMuktaBold).copyWith(color:taskBegin == false ? kGreenColor : kSteelBlue)
                        // (snapshot.data['data']['completed'] == false || snapshot.data['data']['completed'] == 'false') 
                        //             ? ((snapshot.data['data']['started'] == true || snapshot.data['data']['started'] == 'true') 
                        //             ? "Start Consultation" : "End Consultation" ): "",style : mediumLargeTextStyle(context,fontFamily : kMuktaBold).copyWith(color:taskBegin == false ? kGreenColor : kSteelBlue)
                                    )),
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
                        snapshot.data['data']['completed'] == false ? "Pending".toUpperCase() : "Completed".toUpperCase(),
                        style: mediumTextStyle(context,fontFamily:kMuktaBold)
                        
                      ),
                  ],
                ),
                mediumCustomSizedBox(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Customer Name",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: smallTextStyle(context).copyWith(
                            height: 1.2, color: kGraycolor, fontFamily: kMuktaBold),
                      ),
                      Text(
                        snapshot.data['data']['customer_id']['name'].toString().toUpperCase(),
                        style: mediumTextStyle(context,fontFamily:kMuktaBold)
                            
                      ),
                  ],
                ),
                 mediumCustomSizedBox(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Date",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: smallTextStyle(context).copyWith(
                            height: 1.2, color: kGraycolor, fontFamily: kMuktaBold),
                      ),
                      Text(
                        isEmptyOrNull(snapshot.data['data']['customer_id']['service_date']) ? "08-09-2022" : snapshot.data['data']['customer_id']['service_date'].toString().toUpperCase(),
                        style: mediumTextStyle(context,fontFamily:kMuktaBold)
                          
                      ),
                  ],
                ),
                 mediumCustomSizedBox(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Address",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: smallTextStyle(context).copyWith(
                            height: 1.2, color: kGraycolor, fontFamily: kMuktaBold),
                      ),
                      Text(
                        isEmptyOrNull(snapshot.data['data']['customer_id']['address'])? "No:43,KMR Street,Kovur,Chennai-112" : snapshot.data['data']['customer_id']['address'].toString().toUpperCase(),
                        style: mediumTextStyle(context,fontFamily:kMuktaBold)
                          
                      ),
                  ],
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
                  isCancelled: true,
                  timeline: snapshot.data['data'], 
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
                        snapshot.data['data']['customer_id']['name'],
                        maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                        style: mediumTextStyle(context)
                            .copyWith(color: Colors.black.withOpacity(0.9),fontFamily:kMuktaBold),
                      ),
                                Text(
                                  isEmptyOrNull(snapshot.data['data']['worker_id']['phone_number']) ? "9876128729" : snapshot.data['data']['worker_id']['phone_number'].toUpperCase(),
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
                if(snapshot.data['data']['completed'] == false) GestureDetector(
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
          );
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
          ) 
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
          
          _stepperWidget(title: "Start Task", time: isEmptyOrNull(timeline['start_time']) ? "10:30 am" : timeline['start_time'].substring(0,8), isCancelled: false, isLast: false, completed: true),
          _stepperWidget(title: "End Task", time: isEmptyOrNull(timeline['end_time']) ? "-" : timeline['end_time'].substring(0,8), isCancelled: false, isLast: true, completed: timeline['completed']),

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