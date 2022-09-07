/*----------------Different Custom Navbar of the app -------------------*/

import 'package:client/helpers/headers.dart';

/*--------------------------Navbar with Location files and Shopping Cart Icons--------------------------------------*/

//Cart Navbar includes Food/Shopping/Mart/Groceries Navbar
//Keep search bar as constants and passing parameters
class CommonNavbar extends StatelessWidget {
  final bool isBack;
  final bool isElevation;
  final String title;
  final bool isHelp;
  final TextStyle titleStyle;
  const CommonNavbar(
      {Key? key,
      required this.isHelp,
      required this.titleStyle,
      required this.title,
      required this.isElevation,
      required this.isBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);

    double cartNavHeight = smallMobile(context)
        ? 75
        : largeMobile(context)
            ? 75
            : isBetweenMT2(context)
                ? 80
                : isBetweenMT1(context)
                    ? 90
                    : largeTablet(context)
                        ? 80
                        : ultraLargeTablet(context)
                            ? 80
                            : 80;

    return PreferredSize(
      preferredSize: Size.fromHeight(isMobile(context)
          ? 40
          : largeTablet(context)
              ? 50
              : 55),
      child: Container(
        width: size.width,
        height: cartNavHeight,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          if (isElevation == true)
            BoxShadow(
                color: kTertiaryColor,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 0.8))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isBack == true)
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: kPrimaryColor,
                          size: isMobile(context) ? 19 : 23,
                        )),
                  RotatedBox(quarterTurns: 1,child: smallCustomSizedBox(context),),
                  if(title != null) Text(title,style:mediumTextStyle(context))
                ],
              ),
            ),
            if(isHelp == true) GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.contact_support,
                          color: kPrimaryColor,
                          size: isMobile(context) ? 19 : 23,
                        )),
          ],
        ),
      ),
    );
  }
}

//Cart Navbar Widget with PreferredSize widget
Widget commonNavbar({required context,required bool isHelp,required bool isBack,required String title,required TextStyle titleStyle,
    required bool isElevation}) {
  return PreferredSize(
      child: CommonNavbar(
        isBack: isBack,
        isElevation: isElevation,
        isHelp: isHelp,
        title: title,
        titleStyle: titleStyle,
      ),
      preferredSize: Size.fromHeight(isMobile(context)
          ? 40
          : largeTablet(context)
              ? 50
              : 55));
}