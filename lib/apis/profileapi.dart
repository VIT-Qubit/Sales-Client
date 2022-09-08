import 'package:client/helpers/headers.dart';
import 'package:client/screen/auth/loginpage.dart';

class ProfileScreenAPI{

  getProfileScreen({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    try {
      print("----ProfileAPI----");
      Response response = await dio.get(PROFILE_URL,options : dioOptions);
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
          print("${e.message} + ${e.type} in profile api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

}