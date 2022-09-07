import 'package:client/helpers/headers.dart';

class ReferralCode extends StatefulWidget {
  static const routeName = refferalCodeRouter;
  const ReferralCode({ Key? key }) : super(key: key);

  @override
  _ReferralCodeState createState() => _ReferralCodeState();
}

class _ReferralCodeState extends State<ReferralCode> {
  
  TextEditingController _codeController = new TextEditingController();

  @override
    void initState() {
      super.initState();
    }    

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: defaultNavbar(context: context,isBack: true,isElevation: false,isHelp: false,title: "",titleStyle: largeTextStyle(context)),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal:kDefaultScreenPaddingHorizontal(context)),
                  child:   Text("Refer & Reward",style: largeTextStyle(context)),
                    
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:kDefaultScreenPaddingHorizontal(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mediumCustomSizedBox(context),
                      Container(
                        height: isMobile(context) ? size.width / 2.0 : size.width / 3.0,
                        width: size.width - 40,
                        child: Image.asset(REFFERAL_IMG,fit: BoxFit.contain,)),
                      mediumCustomSizedBox(context),
                      Text("Refer a Friend to Get Discount",style: mediumTextStyle(context).copyWith(fontSize: isMobile(context) ? 19.0 : 23.0),),
                      smallCustomSizedBox(context),
                      Text("Share it to your friends",style: mediumTextStyle(context).copyWith(fontFamily : kMuktaRegular,),),
                      mediumCustomSizedBox(context),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:kDefaultScreenPaddingHorizontal(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex:2,
                            child: Container(
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: kAliceBlueColor,
                                border: Border.all(color: kLavenderGrayColor, width: 0.5),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 0,
                                    color: kLavenderGrayColor,
                                    offset: Offset(0, 0)
                                  )
                                ]
                              ),
                              child: Center(
                                child: Text("RSAQER",style: largeTextStyle(context).copyWith(color:kPrimaryColor,fontFamily:kQuickSandBold)),
                              ),
                            ),
                          ),
                          RotatedBox(quarterTurns: 1,child:mediumCustomSizedBox(context)),
                         GestureDetector(
                            onTap: ()async {
                              //TODO SHARE FEATURE
                              // String share_text = "Share this code : RSAQER to your friends and get discount";
                              // Clipboard.setData(ClipboardData(text: share_text));
                              // await Share.share(share_text);
                            },
                           child: Container(
                             height: 35.0,
                             decoration: BoxDecoration(
                                  color: kAliceBlueColor,
                                  border: Border.all(color: kLavenderGrayColor, width: 0.5),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 0,
                                      color: kLavenderGrayColor,
                                      offset: Offset(0, 0)
                                    )
                                  ]
                                ),
                            padding: EdgeInsets.all(8.0),
                             child: Center(
                               child: Icon(Icons.share_outlined,size: 20.0),
                             ),
                           ),
                         )
                        ],
                      ),
                      mediumCustomSizedBox(context),
                      mediumCustomSizedBox(context),
                      lineDivider(context,thickness:1),
                      mediumCustomSizedBox(context),
                      mediumCustomSizedBox(context),
                      
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Your Friend's Referral Code",style: mediumTextStyle(context).copyWith(fontSize: isMobile(context) ? 19.0 : 23.0),),
                      smallCustomSizedBox(context),
                      Text("Get 20% off at your first discount",style: mediumTextStyle(context).copyWith(fontFamily : kMuktaRegular,),),
                      mediumCustomSizedBox(context),
                      Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kPrimaryColor,width: 1.3),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: TextFormField(
        controller: _codeController,
        style: TextStyle(color: kBlackTextColor, fontSize: 17.0),
        keyboardType: TextInputType.text,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "ENTER CODE",
          hintStyle: TextStyle(color: kDimGray, fontSize: 14.0,fontFamily: kMuktaBold,wordSpacing: 1.5),
          contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
          suffixIcon: InkWell(
              onTap:() async{
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              child: Text(
                "Apply",
                style: mediumTextStyle(context).copyWith(color:kPrimaryColor ),
              ),
            ),
          ),
        ),
      ),
    ),
                      
                        ],
                      )
                    ],
                  ),
                ),
                mediumCustomSizedBox(context),
                mediumCustomSizedBox(context),
              ],
            ),
          )
        ),
      )
    );
  }
}