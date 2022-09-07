import 'dart:async';

import 'package:client/apis/authapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
class LoginPage extends StatefulWidget {
  static const routeName = loginPageRoute;
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  int otpTimeout = 10;
  int start = 10;
  late Timer _timer;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  
  String _smsCode = "00000";
  String _otpValue = "00000";

  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  
  
  _postMobileNumber({required String mobileNumber})async{
    return await _authenticationAPI.postLoginUser(context: context, phonenumber: mobileNumber).then((response) {
      if(response == false){
        setState(() {
          wait = false;
          buttonName = "Send";
          start = otpTimeout;
          _timer.cancel();
        });
      }else{
        setState(() {
          _smsCode = response['RESPONSE']['code'];
        });
      }
      Loader.hide();
    });
  }


  _postOtpCodeVerification({required String code,required String otp})async{
    return await _authenticationAPI.postOtpVerification(context: context, otp: otp, code: code);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultScreenPaddingHorizontal(context)),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text("Sign In".toUpperCase(),style: largeTextStyle(context).copyWith(fontFamily:kQuickSandBold)),
                const SizedBox(
                  height: 50,
                ),
              
                textField(),
                 const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Couldn't login?",
                        style: mediumTextStyle(context).copyWith(fontFamily:kMuktaRegular),
                      ),
                      TextSpan(
                        text: " Help",
                        style: mediumTextStyle(context).copyWith(color:kTertiaryColor),
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.5,
                          color: kBlackTextColor,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      Text(
                        "Enter 5 digit OTP",
                        style: mediumTextStyle(context),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.5,
                          color: kBlackTextColor,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                otpField(),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in ",
                      style: mediumTextStyle(context).copyWith(fontFamily:kMuktaRegular),
                    ),
                    TextSpan(
                      text: "$start",
                      style: mediumTextStyle(context).copyWith(color:kTertiaryColor),
                    ),
                    TextSpan(
                      text: " sec ",
                      style:  mediumTextStyle(context).copyWith(fontFamily:kMuktaRegular)
                    ),
                  ],
                )),
                const SizedBox(
                  height: 80,
                ),
               
                InkWell(
                  onTap: _otpValue == "00000"  ? null : () async{
                    if(_otpValue.length == 5){
                    _postOtpCodeVerification(code: _smsCode, otp: _otpValue);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter valid 5 digit OTP"));
                  }},
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                        color: _otpValue == "00000" ? kGraycolor : kPrimaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                mediumCustomSizedBox(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget otpField() {
    return OTPTextField(
      length: 5,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: kTertiaryColor.withOpacity(0.3),
        borderColor: Colors.white
      ),
      style: mediumTextStyle(context).copyWith(color:kPrimaryColor),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      keyboardType: TextInputType.number,
      outlineBorderRadius: 5,
      onChanged: (pin){
        setState(() {
          _otpValue = pin;
        });
      },
      onCompleted: (pin) async{},
    );
  }

  Widget textField() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kPrimaryColor,width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: phoneController,
        style: TextStyle(color: kBlackTextColor, fontSize: 17),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
          ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Mobile number",
          hintStyle: TextStyle(color: kDimGray, fontSize: 17),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              "+91",style: smallTextStyle(context),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                   if(phoneController.text.length == 10){
                     overlayLoader(context);
                    _postMobileNumber(mobileNumber: phoneController.text);
                    setState(() {
                      start = otpTimeout;
                      wait = true;
                      buttonName = "Resend";
                    });
                    startTimer();
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter valid mobile number"));
                  }    
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                buttonName,
                style: mediumTextStyle(context).copyWith(color: wait ? Colors.grey : kPrimaryColor,
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}