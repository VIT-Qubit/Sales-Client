import 'package:client/helpers/headers.dart';
import 'package:client/screen/auth/loginpage.dart';

class RecordsInDetailAPI{

  getIndetailScreen({required BuildContext context,required String ticket_id}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    try {
      print("----Indetail----");
      Response response = await dio.get("$RECORDS_INDETAIL_URL?ticket_id=$ticket_id",options : dioOptions);
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
          print("${e.message} + ${e.type} in detail  api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

  postStatusConsultation({required BuildContext context,required String type,required String ticket_id}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    FormData data = FormData.fromMap({
      "ticket_id" : ticket_id,
      "type" : type
    });
    try {
      print("----Indetail POST----");
      Response response = await dio.post(UPDATE_TASK_STATUS_URL,data:data,options : dioOptions);
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
          print("${e.message} + ${e.type} in detail  api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }


}