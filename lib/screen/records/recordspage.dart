import 'package:client/helpers/headers.dart';
import 'package:client/screen/components/navbar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RecordsPage extends StatefulWidget {
  static const routeName = recordsPageRoute;
  RecordsPage({Key? key}) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultNavbar(
          context: context,
          isHelp: true,
          isBack: false,
          title: "Live Jobs",
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
                              _target(
                                  title: "Tasks Available",
                                  subtitle: "Complete all your tasks available for today",
                                  completedtask: "5",
                                  totaltask: "8",
                                  totalSteps: 100,
                                  currentStep: 40),
                              mediumCustomSizedBox(context),
                            ],
                          )),
                      
                    ],
                  ),
                ),


                /// Todays Earning
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
                                    child: _cardsBox(
                                        title: "Total Task",
                                        subtitle: "10")),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: smallCustomSizedBox(context)),
                                Expanded(
                                    child: _cardsBox(
                                        title: "Completed Task",
                                        subtitle: "8")),
                              ],
                            ),
                            mediumCustomSizedBox(context),
                            underlineTitleText(
                              context: context,
                              lineColor: kPrimaryColor,
                              textColor: kPrimaryColor,
                              text: "Today's Performance",
                            ),
                            smallCustomSizedBox(context),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: _performanceBox(
                                        title: "Orders", subtitle: "10")),
                                Expanded(
                                    child: _performanceBox(
                                        title: "Trips", subtitle: "8")),
                                Expanded(
                                    child: _performanceBox(
                                        title: "Missed", subtitle: "2")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///Weekly Earnings
                Container(
                  child: Column(
                    children: [
                      containerTitleBar(context: context, title: "My Earnings"),
                      Container(
                        padding: screenPads(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Choose Date Range",
                                style: smallTextStyle(context).copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600)),
                            smallCustomSizedBox(context),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("27 May - 4 Jun",
                                    style: smallTextStyle(context)
                                        .copyWith(color: kDarkSlateGray)),
                                Icon(Icons.date_range_outlined,
                                    color: kDarkSlateGray, size: 18)
                              ],
                            ),
                            smallCustomSizedBox(context),
                            kSmallDivider(context),
                            mediumCustomSizedBox(context),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: _cardsBox(
                                        title: "Trip Earnings",
                                        subtitle: "${INRSymbol}1200")),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: smallCustomSizedBox(context)),
                                Expanded(
                                    child: _cardsBox(
                                        title: "Bonus Earnings",
                                        subtitle: "${INRSymbol}75")),
                              ],
                            ),
                            mediumCustomSizedBox(context),
                            underlineTitleText(
                              context: context,
                              lineColor: kPrimaryColor,
                              textColor: kPrimaryColor,
                              text: "Weekly Performance",
                            ),
                            smallCustomSizedBox(context),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: _performanceBox(
                                        title: "Orders", subtitle: "23")),
                                Expanded(
                                    child: _performanceBox(
                                        title: "Trips", subtitle: "20")),
                                Expanded(
                                    child: _performanceBox(
                                        title: "Missed", subtitle: "3")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                mediumCustomSizedBox(context),
                
              
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _cardsBox({required String title, required String subtitle}) {
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
            Text("$title",
                softWrap: true,
                textAlign: TextAlign.center,
                style: mediumLargeTextStyle(context)),
            smallCustomSizedBox(context),
            Text(
              "$subtitle",
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

  Widget _performanceBox({required String title, required String subtitle}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: kLavenderGrayColor, width: 1),
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: mediumTextStyle(context),
          ),
          smallCustomSizedBox(context),
          Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kTertiaryColor,
              ),
              child: Center(
                  child: Text(
                "$subtitle",
                style: mediumTextStyle(context),
              ))),
        ],
      ),
    );
  }

  Widget _target(
      {required String title,
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
            text: "$title",
          ),
          smallCustomSizedBox(context),
          Wrap(
            children: [
              Text("$subtitle",
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
  

}
