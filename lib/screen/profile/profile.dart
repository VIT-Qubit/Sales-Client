import 'package:client/apis/authapi.dart';
import 'package:client/apis/profileapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screen/profile/referral.dart';

class ProfilePage extends StatefulWidget {
  static const routeName =  profilePageRoute;
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

ProfileScreenAPI _profileScreenAPI = new ProfileScreenAPI();

@override initState(){
  super.initState();
  profileFuture = getProfileScreenData();
}

getProfileScreenData() async {
  return await _profileScreenAPI.getProfileScreen(context: context);
}

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
      child: Scaffold(
        body:
        FutureBuilder(
            future: profileFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      mediumCustomSizedBox(context),
                      mediumCustomSizedBox(context),
        
                      ///User Details
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kScreenMarginHorizontal(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data['Data']['name'],
                              style: largeTextStyle(context),
                            ),
                            smallCustomSizedBox(context),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['Data']['phone_number'],
                                  style: mediumTextStyle(context)
                                      .copyWith(color: kDimGray),
                                ),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: mediumCustomSizedBox(context)),
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: kDimGray),
                                ),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: mediumCustomSizedBox(context)),
                                Expanded(
                                    child: Text(
                                      snapshot.data['Data']['age'].toString(),
                                  style: mediumTextStyle(context)
                                      .copyWith(color: kDimGray),
                                ))
                              ],
                            ),
                            mediumCustomSizedBox(context),
                            lineDivider(context,
                                thickness: 1, color: kBlackTextColor),
                          ],
                        ),
                      ),
                      mediumCustomSizedBox(context),
                      mediumCustomSizedBox(context),
        
                      ///Profiles
                      profileTiles(
                          title: "History Tasks",
                          icon: Icons.history,
                          onTap: () {}),
                      
                      profileTiles(
                          title: "Issues",
                          icon: Icons.report_problem_outlined,
                          onTap: () {}),
                      profileTiles(
                          title: "Refer & Earn",
                          icon: Icons.local_offer_outlined,
                          onTap: () => Navigator.push(
                              context,
                              CustomRightPageRoute(
                                  page: ReferralCode(),
                                  routeName: refferalCodeRouter))),
                      profileTiles(
                          title: "Help & Support",
                          icon: Icons.help,
                          onTap: () {}),
        
                      profileTiles(
                          title: "Terms & Conditions",
                          icon: Icons.rule_sharp,
                          onTap: () {}),
        
                      profileTiles(
                          title: "Privacy Policy",
                          icon: Icons.sticky_note_2_outlined,
                          onTap: () {}),
        
                      profileTiles(
                          title: "Logout",
                          icon: Icons.logout,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(customSnackSuccessBar(context, "You have been logged out"));
                            AuthenticationAPI().performLogOut(context: context, userLogout: true);
                            }
                          ),
        
                      ///Version
                      Container(
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: kScreenMarginHorizontal(context)),
                        child: Column(
                          children: [
                            mediumCustomSizedBox(context),
                            mediumCustomSizedBox(context),
                            lineDivider(context,
                                thickness: 0.5, color: kBlackTextColor),
                            mediumCustomSizedBox(context),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "v1.1.0",
                                style: smallTextStyle(context),
                              ),
                            ),
                            mediumCustomSizedBox(context),
                          ],
                        ),
                      )
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
                      width: sizeMedia(context).width,
                      height: sizeMedia(context).height,
                      child: Center(child: customCircularProgress()));
            },
          )
      ),
    );
  }

  Widget profileTiles(
      {required String title,
      required IconData icon,
      required Function() onTap}) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: kScreenMarginHorizontal(context)),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: Icon(icon),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: kMuktaRegular,
              ),
            ),
            trailing: Icon(Icons.arrow_right),
            tileColor: kAliceBlueColor,
          ),
          smallCustomSizedBox(context),
        ],
      ),
    );
  }

}