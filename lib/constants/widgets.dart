

/*---------------- Custom Widgets which is common for whole app -------------------*/
 
import 'package:client/helpers/headers.dart';

/* ------------------------ INR Symbols -------------------------*/
const String INRSymbol = "\u{20B9}";

/* ---------------MediaQuery--------------------------------*/
sizeMedia(BuildContext context) {
  return MediaQuery.of(context).size;
}

/* ---------------Default Padding and Margin--------------------------------*/
const kDefaultPadding = 30.0;

/* ---------------Default Screen Margin--------------------------------*/
//Used in Authentication Pages
kScreenMarginHorizontal(context) {
  return isMobile(context) ? kDefaultPadding - 15.0 : kDefaultPadding * 1.5;
}

/* ---------------Default Screen Padding--------------------------------*/
//Used in Main Screen Pages
kDefaultScreenPaddingHorizontal(context) {
  return isMobile(context) ? 14.0 : 17.0;
}

kDefaultScreenPaddingVertical(context) {
  return isMobile(context) ? 10.0 : 14.0;
}

screenPads(context) {
  return EdgeInsets.symmetric(
      horizontal: kDefaultScreenPaddingHorizontal(context),
      vertical: kDefaultScreenPaddingVertical(context));
}

/* -------------- Text Style --------------*/
largeTextStyle(context) {
  return TextStyle(
    color: kBlackTextColor,
    fontFamily: kMuktaBold,
    fontSize: isMobile(context) ? 21.0 : 24.0,
  );
}

mediumLargeTextStyle(context) {
  return TextStyle(
    fontFamily: kMuktaRegular,
    fontSize: isMobile(context) ? 18.0 : 20.0,
    color: kBlackTextColor,
  );
}

mediumTextStyle(context) {
  return TextStyle(
    fontFamily: kMuktaRegular,
    fontSize: isMobile(context) ? 15.0 : 17.0,
    color: kBlackTextColor,
  );
}

smallTextStyle(context) {
  return TextStyle(
      fontFamily: kQuickSandRegular,
      fontSize: isMobile(context) ? 13.0 : 15.0,
      color: kGraycolor);
}

/* ---------------Custom Divider Gray Box--------------------------------*/
kLargeDivider(context) {
  return Container(
      decoration: BoxDecoration(color: kSlateGray),
      height: isMobile(context) ? 11.0 : 13.0);
}

kMediumDivider(context) {
  return Container(
      decoration: BoxDecoration(color: kSlateGray),
      height: isMobile(context) ? 6.0 : 9.0);
}

kSmallDivider(context, {Color? lineColor}) {
  return Container(
      decoration: BoxDecoration(color: lineColor ?? kSlateGray),
      height: isMobile(context) ? 1.5 : 3.0);
}

/* ---------------Custom Line Divider--------------------------------*/
lineDivider(context, {double? thickness, Color? color}) {
  return Divider(
    color: color ?? kLavenderGrayColor,
    thickness: thickness ?? (isMobile(context) ? 0.1 : 0.25),
    endIndent: 2.0,
    indent: 2.0,
    height: 1.0,
  );
}

/* ---------------Custom Sized Box Divider--------------------------------*/
Widget mediumCustomSizedBox(context) {
  return SizedBox(height: isMobile(context) ? 15.0 : 22.0);
}

Widget smallCustomSizedBox(context) {
  return SizedBox(height: isMobile(context) ? 6.0 : 9.0);
}

/* ---------------Single Promotions Box-------------------------------*/
class SinglePromotionBox extends StatelessWidget {
  final String imgUrl;
  final String title;
  const SinglePromotionBox(
      {Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return Container(
      width: size.width,
      height: isMobile(context) ? size.height / 5.0 : size.height / 3.5,
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultScreenPaddingHorizontal(context),
          vertical: kDefaultScreenPaddingVertical(context)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          image:
              DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgUrl))),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            margin: EdgeInsets.only(
                left: kDefaultScreenPaddingHorizontal(context), bottom: 12.0),
            child: Text(
              title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: largeTextStyle(context)
                  .copyWith(color: Colors.white, letterSpacing: 1.5),
            )),
      ),
    );
  }
}

class DisplayImageBox extends StatelessWidget {
  final String imgUrl;
  const DisplayImageBox({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return Container(
      width: size.width,
      height: isMobile(context) ? size.height / 3.5 : size.height / 2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          image:
              DecorationImage(fit: BoxFit.fill, image: NetworkImage(imgUrl))),
    );
  }
}

/* ---------------Shop Image Dimensions --------------- */
double imgShopDim(context) {
  return smallMobile(context)
      ? 70.0
      : largeMobile(context)
          ? 70.0
          : isBetweenMT2(context)
              ? 75.0
              : isBetweenMT1(context)
                  ? 100.0
                  : isBetweenTD2(context)
                      ? 120.0
                      : 120.0;
}

/* ---------------Product Image Dimensions --------------- */
double imgProdDim(context) {
  return smallMobile(context)
      ? 60.0
      : largeMobile(context)
          ? 60.0
          : isBetweenMT2(context)
              ? 75.0
              : isBetweenMT1(context)
                  ? 80.0
                  : isBetweenTD2(context)
                      ? 90.0
                      : 100.0;
}

/* --------------- CUstom Image Scroll Animation --------------- */
Widget animatedImage({context, String? imgUrl}) {
  var size = sizeMedia(context);
  return SliverAppBar(
    toolbarHeight: 0,
    pinned: true,
    backgroundColor: Colors.transparent,
    expandedHeight: isMobile(context) ? size.height / 4.5 : size.height / 3.0,
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.parallax,
      background: Container(
        margin: EdgeInsets.symmetric(
            horizontal: kDefaultScreenPaddingHorizontal(context),
            vertical: kDefaultScreenPaddingVertical(context)),
        width: size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.network(
            "${imgUrl}",
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

/* --------------- CUstom Full Screen Image Scroll Animation --------------- */
Widget animatedFullImage({context, required String imgUrl}) {
  var size = sizeMedia(context);
  return SliverAppBar(
    toolbarHeight: 0,
    pinned: true,
    backgroundColor: Colors.transparent,
    expandedHeight: isMobile(context) ? size.height / 4.0 : size.height / 3.0,
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.parallax,
      background: Container(
        width: size.width,
        child: ClipRRect(
          child: Image.network(
            imgUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

/*--------------- Text Style ----------------*/
titleStyle(context) {
  return TextStyle(
    fontFamily: kMuktaBold,
    fontSize: isMobile(context) ? 18.5 : 23.5,
  );
}

/* ---------------  Small Black Button --------------- */
Widget smallCustomButton(
    {required BuildContext context,
    required String text,
    required bool customMargin,
    required Color color,
    EdgeInsetsGeometry? marginValue,
    bool outlineButton = false}) {
  var size = sizeMedia(context);
  return Container(
    margin: customMargin == false
        ? EdgeInsets.only(
            right: kScreenMarginHorizontal(context),
            left: kScreenMarginHorizontal(context),
            bottom: isMobile(context) ? 15.0 : 11.0,
          )
        : marginValue,
    height: isMobile(context) ? 35.0 : 35.0,
    width: size.width,
    decoration: BoxDecoration(
      color: outlineButton == false ? color : Colors.white,
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            color: outlineButton == false ? Colors.white : color,
            fontFamily: kQuickSandRegular),
      ),
    ),
  );
}

/* -------------------Text Highlighter----------------------------*/
Widget titleText(
    {context,
    required String text,
    required Color textColor,
    TextStyle? textStyle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        text,
        style: textStyle ??
            TextStyle(
              fontFamily: kMuktaRegular,
              fontSize: isMobile(context) ? 20.0 : 24.0,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      SizedBox(
        height: 4.0,
      ),
      Container(
                  height: 2.0,
                  width: sizeMedia(context).width / 8,
                  decoration: BoxDecoration(
                    color: kDimGray,
                    borderRadius: BorderRadius.circular(20), 
                  ),
                )
    ],
  );
}

Widget titleBtn(
    {context,
    required String text,
    Color? textColor,
    required Color bgColor,
    TextStyle? textStyle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: bgColor,
        ),
        child: Text(
          text,
          style: textStyle != null
              ? textStyle.copyWith(color: textColor)
              : TextStyle(
                  fontFamily: kMuktaRegular,
                  fontSize: isMobile(context) ? 19.0 : 24.0,
                  color: textColor,
                ),
        ),
      ),
      SizedBox(
        height: 4.0,
      ),
    ],
  );
}

Widget circularBtn(
    {context,
    required String text,
    required Color textColor,
    required Color bgColor,
    TextStyle? textStyle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: bgColor,
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          text,
          style: textStyle != null
              ? textStyle.copyWith(color: textColor)
              : TextStyle(
                  fontFamily: kMuktaRegular,
                  fontSize: isMobile(context) ? 19 : 24,
                  color: textColor,
                ),
        ),
      ),
      SizedBox(
        height: 4,
      ),
    ],
  );
}

/* -------------- ListView Builder--------------*/
class SearchListBuilder extends StatelessWidget {
  final List<dynamic> serviceslist;
  const SearchListBuilder({Key? key, required this.serviceslist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return ListView.builder(
        addAutomaticKeepAlives: true,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: serviceslist.length,
        itemBuilder: (BuildContext context, int i) {
          print(serviceslist);
          return Container(
            margin: EdgeInsets.all(5.0),
            child: SizedBox(
                //height: 100,
                child: GestureDetector(
                  // onTap: () => Navigator.push(
                  //                   context,
                  //                   CustomRightPageRoute(
                  //                       page: ServicesBrief(
                  //                         serviceId: serviceslist[i]["id"]
                  //                       ),
                  //                       routeName: servicebrief)),
                  child: Card(
                      elevation: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.0),
                            child: Image.network(
                              isEmptyOrNull(serviceslist[i]['img'])
                                  ? //TODO : Default Img here
                                  "https://newsroom.unsw.edu.au/sites/default/files/styles/full_width__2x/public/thumbnails/image/5_junk_food_shutterstock_1.jpg?itok=c5nf36Rt"
                                  : "${serviceslist[i]['img']}",
                              fit: BoxFit.cover,
                              height: isMobile(context)
                                  ? size.width / 4.0
                                  : size.width / 5.5,
                              width: isMobile(context)
                                  ? size.width / 4.0
                                  : size.width / 5.5,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: mediumCustomSizedBox(context),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                mediumCustomSizedBox(context),
                                Text(
                                  isEmptyOrNull(serviceslist[i]['name']) ? "Specials" : "${serviceslist[i]['name']}",
                                  style: mediumTextStyle(context), //smallTextStyle(context).copyWith(fontFamily: KMuktaRegular,color: kBlackTextColor,),
                                  maxLines: 3,
                                  overflow: TextOverflow.clip,
                                ),
                                smallCustomSizedBox(context),
                                Text(
                                  "Book now",
                                  style: smallTextStyle(context).copyWith(
                                      color: kPrimaryColor,
                                      fontFamily: kQuickSandBold),
                                ),
                                smallCustomSizedBox(context),
                                lineDivider(context),
                              ],
                            ),
                          )
                        ],
                      )),
                )),
          );
          /*
                Card(
                  elevation: 0,
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                    "https://newsroom.unsw.edu.au/sites/default/files/styles/full_width__2x/public/thumbnails/image/5_junk_food_shutterstock_1.jpg?itok=c5nf36Rt",
                    fit: BoxFit.cover,
                    height : isMobile(context) ? size.width / 3.5 : size.width / 5.5,
                    width: isMobile(context) ? size.width / 3.5 : size.width / 5.5,
                  ),
                  RotatedBox(quarterTurns: 1,
                  child: mediumCustomSizedBox(context),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        smallCustomSizedBox(context),
                        Text("North Indian Veg Cooking",style: mediumTextStyle(context),maxLines: 2,overflow: TextOverflow.clip,),
                        smallCustomSizedBox(context),
                        Text("Book now",style: smallTextStyle(context),)
                        
                        //Text("tandard List Tile, is it possible to align the leading ",style: smallTextStyle(context),maxLines: 3,overflow: TextOverflow.clip),
                      ],
                    ),
                  )
                  ],
                )
                );
                */
        });
  }
}

/* -------------- Text with background color kTertiaryColor --------------*/

Widget textBtn(context, String title,
    {Color? color, TextStyle? style, bool outlineButton = false}) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(
          color: outlineButton == true ? kPrimaryColor : Colors.white,
          width: outlineButton == true ? 1.0 : 0.0),
      color: outlineButton == true ? Colors.white : (color ?? kPrimaryColor),
    ),
    child: Center(
      child: Text(
        title,
        style: style ??
            mediumTextStyle(context).copyWith(
                color: outlineButton == true ? kPrimaryColor : Colors.white),
      ),
    ),
  );
}

isEmptyOrNull(var x) {
  if ((x.toString().isEmpty) || (x == null)) {
    return true;
  } else {
    return false;
  }
}

/* -------------- Bookings -------------- */
Widget bookingsCard(
    {required BuildContext context,
    required String cat,
    required String startDate,
    required String status,
    required String price,
    required Function() onTap}) {
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: kScreenMarginHorizontal(context), vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  isEmptyOrNull(cat) ? "Services" : "$cat",
                  style: mediumTextStyle(context),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                smallCustomSizedBox(context),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        isEmptyOrNull(price)
                            ? "${INRSymbol}"
                            : "${INRSymbol}$price",
                        style: smallTextStyle(context)),
                    RotatedBox(
                        quarterTurns: 1, child: smallCustomSizedBox(context)),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                          color: kDimGray, shape: BoxShape.circle),
                    ),
                    RotatedBox(
                        quarterTurns: 1, child: smallCustomSizedBox(context)),
                    Text(isEmptyOrNull(startDate) ? "" : "$startDate",
                        style: smallTextStyle(context)),
                  ],
                ),
                smallCustomSizedBox(context),
                Text(
                  isEmptyOrNull(status) ? "Status" : (status == "pending") ? "Status : Processing" : "Status : Completed",
                  style: smallTextStyle(context).copyWith(color: status == "pending" ? kRedColor : kGreenColor),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("View",
                        style: mediumTextStyle(context).copyWith(
                            color: kGreenColor, fontFamily: kMuktaRegular)),
                    RotatedBox(
                        quarterTurns: 1, child: smallCustomSizedBox(context)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: kBlackTextColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        mediumCustomSizedBox(context),
        lineDivider(context, color: kBlackTextColor),
      ],
    ),
  );
}

/* --------------Model Bottom Pop Up -------------- */
bottomModelPopUp({required BuildContext context,required Widget widget, double height = 300}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: height,
        color: Colors.white,
        child: Center(child: widget),
      );
    },
  );
}

/* --------------Custom AlertDialog -------------- */
customInfoAlertDialog(
    {required BuildContext context,
    required String title,
    required String message,
    Function()? onTapBtn,
    String btnName = "",
    double alertBoxHgt = 200,
    double alertBtnWidth = 320}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0)), //this right here
          child: Container(
            height: alertBoxHgt,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mediumCustomSizedBox(context),
                  Text(
                    "$title",
                    style: largeTextStyle(context)
                        .copyWith(color: kBlackTextColor),
                  ),
                  smallCustomSizedBox(context),
                  Text(
                    "$message",
                    textAlign: TextAlign.center,
                    style: mediumTextStyle(context).copyWith(color: kDimGray),
                  ),
                  mediumCustomSizedBox(context),
                  if (btnName != "")
                    SizedBox(
                      width: alertBtnWidth,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kSecondaryColor),
                        ),
                        onPressed: onTapBtn ?? (){},
                        child: Text(
                          "$btnName",
                          style: mediumTextStyle(context)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      });
}


defaultErrordialog(
    {required BuildContext context,
    required String errorCode,
    Function()? onTapBtn,
    String message =
        "Oops ! An unknown error occurred.Please try again later"}) {
  return customInfoAlertDialog(
      context: context,
      title: "Error $errorCode",
      message: message,
      btnName: "Close",
      alertBtnWidth: 120,
      onTapBtn: onTapBtn ?? () => Navigator.pop(context));
}

/* --------------Circular Progress Indicator -------------- */
customCircularProgress() {
  return const CircularProgressIndicator(
    //backgroundColor: kPrimaryColor,
    color: kPrimaryColor,
    strokeWidth: 3,
  );
}

/* --------------Emprty Display Box--------------------*/
displayEmptyBox({required BuildContext context,required String text,required IconData icon}){
  return Padding(
              padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height/3 ),
              child: Center(
                child: Column(
                  children: [
                    Icon(icon, color: kSecondaryColor,size: isMobile(context) ?  30 : 50,),
                    Text(text,
                  style: mediumTextStyle(context).copyWith(fontFamily : kMuktaRegular,color : kDimGray),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                  ],
                ),
              ),
            );
}

/*---------------- Empty Display Image Box ---------------*/
displayEmptyImageBox({required BuildContext context,required String text,required String imgSrc}){
  return Padding(
              padding: EdgeInsets.only(top:isMobile(context) ? 80 : 120),
              child: Center(
                child: Column(
                  children: [
                    Image.network(
                      imgSrc,
                      height: isMobile(context) ?  200 : 300,
                      width: isMobile(context) ?  200 : 300,
                    ),
                    Text(text,
                  style: mediumTextStyle(context).copyWith(fontFamily : kMuktaRegular,color : kDimGray),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                  ],
                ),
              ),
            );
}

customsnackErrorBar(BuildContext context, String message) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.white,
        ), 
        const SizedBox(width: 10),
        Expanded(child: Text("$message" , maxLines: 2)),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.redAccent, 
    padding:const EdgeInsets.all(15),
  );
}

customSnackSuccessBar(BuildContext context, String message) {
  return SnackBar(
    content: Text("$message"), 
    // Row(
    //   children: [
    //     Icon(
    //       Icons.info_outline,
    //       color: Colors.white,
    //     ), 
    //     const SizedBox(width: 10),
    //     Text("$message"),
    //   ],
    // ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: kGreenColor, 
    padding:const EdgeInsets.all(15),
  );
}

/*--------------Overlay loader --------------*/

overlayLoader(BuildContext context){
  return Loader.show(context,
          isAppbarOverlay: true,
          isBottomBarOverlay: true,
          overlayColor: Colors.black38,
          progressIndicator:customCircularProgress(),
      );
}

/* --------------- Cutom Dialog --------------- */

/// This dialog shows an Circular icon on top stacked and a single button in the center with action
Widget singleButtonCustomDialog({required context, required String title,
  required Function() onPressed,
  required String btnText,
  required Color circularAvatarColor,
  required IconData icon,}){
  return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('$title', 
                    textAlign: TextAlign.center,
                    style: mediumTextStyle(context)),
                ElevatedButton(
                      onPressed: (){
                        onPressed();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        onPrimary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(2.0),
                        ),
                      ),
                      child: Text(
                        '$btnText',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: circularAvatarColor,
                  radius: 60,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
}

/* ---------------  Vertical Icon Title --------------- */

/// Custom Vertical icon Title and button
Widget customVerticalIconTitle({required context,required String subtitle,required IconData icon}){
  return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(subtitle,style: mediumTextStyle(context),),
                    smallCustomSizedBox(context),
                    Container(
                        width: 33,
                        height: 33,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kSlateGray,
                          shape: BoxShape.circle),
                        child: Center(
                          child: Icon(icon,size: isMobile(context) ? 16 : 19),
                        )),
                  ],
                );
}


/*
Widget bookingsCard({BuildContext context,String refid,String cat,String startDate,String type,Function() onTap}){
  return Container(
                margin: EdgeInsets.symmetric(horizontal: kScreenMarginHorizontal(context),vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: kWhiteSmoke,
                      blurRadius: 0.6,
                      spreadRadius: 0,
                      offset: Offset(0,0)
                    ) 
                  ]
                ),
                padding: EdgeInsets.symmetric(horizontal:14.0,vertical:6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    smallCustomSizedBox(context),
                    Text(isEmptyOrNull(refid) ? "Ref.Id" : "Ref.Id : #$refid",style:  mediumTextStyle(context)),
                    Text(isEmptyOrNull(cat) ? "Services" : "$cat",style: smallTextStyle(context),maxLines: 1,overflow: TextOverflow.clip,),
                    smallCustomSizedBox(context),
                    lineDivider(context,thickness: isMobile(context) ? 0.5 : 0.85),
                    smallCustomSizedBox(context),
                    Text(isEmptyOrNull(startDate) ?"Date" : "$startDate", style:smallTextStyle(context).copyWith(color:kRedColor,fontFamily:kQuickSandBold)),
                    Text(isEmptyOrNull(type) ? "Service" : "$type", style:smallTextStyle(context).copyWith(color:kRedColor,fontFamily:kQuickSandRegular)),
                    smallCustomSizedBox(context),
                    GestureDetector(
                      onTap : onTap,
                      child: textBtn(context,"View Bookings")),
                  ],
                ),
              );
}
 */