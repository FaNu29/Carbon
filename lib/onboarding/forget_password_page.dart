import 'package:carbon/Widgets/button.dart';
import 'package:carbon/onboarding/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../validation/validators.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController forgetPassEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFC8FA9C),
                    Color(0xFF93A87F),
                    Color(0xFF455932),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter


              )

          ),
          child: Form(
            key:formKey,
            child: ListView(
              children: [
                Container(
                  height: height/2.5,
                  width: double.infinity,
                  child: Image.asset("images/forget_pass.png"),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("Forget Password ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25
                  ),),
                ),
                SizedBox( height: 10,),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Enter Your Email Address.",
                       style: TextStyle(
                           fontSize:13,
                           fontWeight: FontWeight.w400,
                           color: Colors.white
                       ),
                     ),
                     Text("We will send You the Link for Reset Password",
                       style: TextStyle(
                           fontSize:13,
                           fontWeight: FontWeight.w400,
                         color: Colors.white
                       ),
                     )
                   ],
                 ),

                 SizedBox(height: 30,),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: forgetPassEmailController,
                      decoration: InputDecoration(

                          hintText: " Email",
                          hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 14
                          ),
                          prefixIcon: Icon(Icons.email_rounded,
                              color: Colors.black45
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xFFedf0f8),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30)
                              )

                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2,
                                  color:Color(0xFF455932)),
                              borderRadius:BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30)
                              )
                          )

                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Email Required";
                        }
                        else if (!validateEmailAddress(value)){
                          return "PLease Enter a valid Email";
                        }
                        return null;
                      }
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(

                  onTap: ()async{
                    final isValid = formKey.currentState?.validate() ?? false;
                    if (!isValid) return;
                    String email = forgetPassEmailController.text.trim();

                    try {
                      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmation Message'),
                              content: const Text("Email has sent successfully"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        ).then(
                              (value) => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            )
                          },
                        )
                      });
                    } on FirebaseAuthException catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Authentication Error'),
                            content: Text(e.message ?? 'An error occurred'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)
                            )
                        ),
                        color: Color(0xFF455932),
                      ) ,
                      child: Text("Send Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),

                    ),
                  ),
                )

              ],
            ),
          ),
        )
        ,
      ),
    );
  }
}
