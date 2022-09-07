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
        child: SingleChildScrollView(
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
                                        subtitle: "10")),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: smallCustomSizedBox(context)),
                                Expanded(
                                    child: cardsBox(context:context,
                                        title: "Completed Task",
                                        subtitle: "8")),
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
                  itemCount: 5,//_recordList.length,
                  itemBuilder: (BuildContext context, int i){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, CustomRightPageRoute(page : RecordsInDetailsPage(),routeName: recordsInDetailsPageRoute));
                      },
                      // onTap: () => Navigator.push(context,CustomRightPageRoute(page:MedicalFilesPage(
                      //   appointmentId: _recordList[i]['appointmentid'].toString(),
                      //   deptId: snapshot.data['deptid'].toString(),
                      //   recordId: snapshot.data['recordid'].toString(),
                      // ),routeName:  medicalrecordspage)),
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
                              Text("Task ID : #123456789",style: mediumTextStyle(context).copyWith(fontFamily : kMuktaBold,letterSpacing: 0.2,color:Colors.black.withOpacity(0.8))),
                              Text("A.Sundaram",
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: mediumTextStyle(context).copyWith(letterSpacing: 0.1,color:kPrimaryColor)),
                              Text("EMI Collector",style:smallTextStyle(context)),
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
        ),
      ),
    );
  }
}