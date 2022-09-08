import 'package:client/helpers/headers.dart';
import 'package:client/screen/auth/loginpage.dart';
import 'package:client/screen/components/appscreencontroller.dart';

class HomeScreenAPI{

  getHomeScreen({required BuildContext context}) async {
var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    try {
      print("----HomeScreenAPI----");
      Response response = await dio.get(HOME_PAGE_URL,options : dioOptions);
      if(response.statusCode == 200) {
        print(response.data);
        return response.data;
      }
    } on DioError catch (e) {
        if(e.response?.statusCode == 404){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Error.Try again"));
          return false;
        } 
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in home  api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }


  postStatus({required BuildContext context,required String type}) async {
var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
        FormData data = FormData.fromMap({"type" : type});
    try {
      print("----HomeScreenAPI----");
      Response response = await dio.post(UPDATE_STATUS_URL,data:data,options : dioOptions);
      if(response.statusCode == 200) {
        print(response.data);
            return Navigator.pushReplacement(context,
        CustomSimplePageRoute(page: AppScreenController(), routeName: appControllerRoute));
      }
    } on DioError catch (e) {
        if(e.response?.statusCode == 404){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Error.Try again"));
          return false;
        } 
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in home  api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

}