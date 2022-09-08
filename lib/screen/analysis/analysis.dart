import 'package:client/apis/analysisapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screen/records/recordsindetail.dart';
import 'package:client/screen/records/recordspage.dart';

class AnalysisPage extends StatefulWidget {
  static const routeName = analysisPageRoute;
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {

  AnalysisScreenAPI _analysisScreenAPI = new AnalysisScreenAPI();

  @override initState(){
    super.initState();
    analysisFuture = getAnalysisData();
  }

getAnalysisData() async {
  return await _analysisScreenAPI.getAnalysisScreen(context: context);
}

  Future<void> _getRefreshedScreen() async {
    setState(() {
    analysisFuture = getAnalysisData();
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
          title: "Jobs Analysis",
          titleStyle: largeTextStyle(context),
          isElevation: true),
      body: SafeArea(
        child: 
        RefreshIndicator(
          onRefresh: _getRefreshedScreen,
          child: FutureBuilder(
              future: analysisFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  List<dynamic> _taskData = snapshot.data['Data'];
                  Map<dynamic, dynamic> _statusData = snapshot.data['status_data'];
                  return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Todays 
                  Container(
                    child: Column(
                      children: [
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
                          Navigator.push(context, CustomRightPageRoute(page : RecordsInDetailsPage(ticket_id: _taskData[i]['id'].toString(),),routeName: recordsInDetailsPageRoute));
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
                    }
                    return SizedBox(
                        width: sizeMedia(context).width,
                        height: sizeMedia(context).height,
                        child: Center(child: customCircularProgress()));
              },
            ),
        )
      ),
    );
  }
}