import 'package:client/helpers/headers.dart';
Widget locationTracker({required context, required String text}){
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Text("$text",
                  maxLines: 1,softWrap: true, overflow: TextOverflow.ellipsis,
                  style: mediumTextStyle(context).copyWith(color:kDarkSlateGray))),
                  RotatedBox(quarterTurns: 1,child: mediumCustomSizedBox(context)),
                  Icon(Icons.assistant_direction,size: 30,color: kSteelBlue,)
                  ],
              );
  }