import 'package:client/helpers/headers.dart';
import 'package:client/screen/auth/loginpage.dart';
import 'package:client/screen/components/appscreencontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class AuthenticationAPI {
  //Initialize the plugin dio
  //Dio dio = new Dio(dioOptions);
  postLoginUser({required BuildContext context,required String phonenumber}) async {
    FormData data = FormData.fromMap({
      "mobilenumber": phonenumber,
    });

    try {
      Response response = await dio.post(LOGIN_URL,options : dioOptions,data : data);
      if(response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(customSnackSuccessBar(context, "OTP was sent successfully"));
        return response.data;
      }
    } on DioError catch (e) {
        if(e.response?.statusCode == 404){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Number does not exist.Try Sign Up"));
          return false;
        }
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in login api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

  postOtpVerification(
      {required BuildContext context,
      required String otp,
      required String code}) async {
    FormData data = FormData.fromMap({"otp": otp, "code": code});
final _flutterSecureStorage =  FlutterSecureStorage();
    try {
      Response response = await dio.post(VERIFY_OTP_URL,options : dioOptions,data : data);
      if(response.statusCode == 200) {
        print(response.data);
        var bearerToken = response.data['token'];
        await _flutterSecureStorage.write(key: "BEARERTOKEN", value: bearerToken);
        Loader.hide();
        return Navigator.pushReplacement(context, CustomSimplePageRoute(page: const AppScreenController(), routeName: appControllerRoute));
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
            customsnackErrorBar(context, "OTP expired or incorrect.Try again"));
        return false;
      } else if (e.response?.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(
            context, "The OTP entered was incorrect.Try again"));
        return false;
      } else {
        print("Response Code is ${e.response?.statusCode}");
        print("${e.message} + ${e.type} in login api");
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context,
            "Oops! An unknown error occured. Please try again later."));
        return false;
      }
    }
  }

 postResendOtp(
      {required BuildContext context, required String phonenumber}) async {
        FormData data = FormData.fromMap({
      "number": phonenumber,
    });

    try {
      Response response = await dio.post(LOGIN_URL,options : dioOptions,data : data);
      if(response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(customSnackSuccessBar(context, "OTP was sent successfully"));
        return response.data;
      }
    } on DioError catch (e) {
        if(e.response?.statusCode == 404){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Number does not exist.Try Sign Up"));
          return false;
        }
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in login api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

  ///userLogout - Refers to user performing logout on his own and not through external factors
  performLogOut({required BuildContext context,required bool userLogout}) async {
    await flutterSecureStorage.delete(key: "BEARERTOKEN");
    if(userLogout == true) {
      ScaffoldMessenger.of(context).showSnackBar(customSnackSuccessBar(context, "Logged out successfully"));
    }
    return Navigator.pushReplacement(context,
        CustomSimplePageRoute(page: LoginPage(), routeName: loginPageRoute));
  }
}