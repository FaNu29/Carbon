import 'dart:async';

import 'package:carbon/HomeScreen/HomePg.dart';
import 'package:carbon/Widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../validation/validators.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController phoneController = TextEditingController();
  final List<TextEditingController> _otpController =
  List.generate(6, (index) => TextEditingController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int start = 50;
  bool wait = false;
  String buttonName = "Send OTP";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  String smsCode = "";


  void setData(verficationID) {
    setState(() {
      verificationID = verficationID;
    });
    startTimer();
  }

  Future<void> phoneAuthentication(String verificationId, String smsCode,
      BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder) => Homepg()), (route) => false);

      showSnackBar(context, "Verification Completed");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context,
      Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };

    PhoneVerificationFailed verificationFailed = (FirebaseException exception) {
      showSnackBar(context, exception.toString());
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingtoken]) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationId);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time Out");
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final defaultPinTheme = PinTheme(
      width: 55,
      height: 70,

      textStyle: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Color(0xFF455932),),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30), topLeft: Radius.circular(30))),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), topLeft: Radius.circular(30)));

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white54,
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFC8FA9C),
              Color(0xFF93A87F),
              Color(0xFF455932),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: ListView(
              children: [
                Container(
                  height: height / 2.9,
                  child: Image.asset("images/otp.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                        hintText: " Phone Number",
                        hintStyle: const TextStyle(
                            color: Colors.black45, fontSize: 14),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            "+880",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFedf0f8),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF455932)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)))),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Phone Number Required";
                      } else if (validatePhoneNumber(val)) {
                        return "Enter a Valid NUmber";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: wait
                      ? null
                      : () async {
                          startTimer();
                          setState(() {
                            start = 50;
                            wait = true;
                            buttonName = "Resend OTP";
                          });
                          await verifyPhoneNumber(
                              "+880 ${phoneController.text.trim()}",
                              context,
                              setData);
                        },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        color: Color(0xFF455932),
                      ),
                      child: Text(
                        buttonName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: wait ? Colors.black45 : Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Verification Code",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onCompleted: (pin){
                      print(pin);
                      setState(() {
                        smsCode = pin;
                      });
                    }
                  ),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Send OTP again in  ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " 00:$start",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "  sec",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ])),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                  onTap: () {
                    phoneAuthentication(verificationID, smsCode, context);
                  },
                  text: "Let's Goo",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          wait = false;
          timer.cancel();
          start = 50;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
