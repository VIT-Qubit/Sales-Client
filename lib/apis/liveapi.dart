import 'package:client/helpers/headers.dart';
import 'package:client/screen/auth/loginpage.dart';

class LiveScreenAPI{

  getLiveScreen({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    try {
      print("----LiveAPI----");
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
          print("${e.message} + ${e.type} in live  api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

  updateLiveLocation({required BuildContext context,required String lat,required String lon})async{
    
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    FormData data = FormData.fromMap({
        "lat": lat,
        "lon": lon
    });

    try {
      print("----Liv Loc API----");
      Response response = await dio.post(LIVE_LOCATION_URL,data:data,options : dioOptions);
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
          print("${e.message} + ${e.type} in live loc api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

}