
import 'package:carbon/onboarding/login_page.dart';
import 'package:carbon/onboarding/otp_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/button.dart';
import '../sevices/models/users.dart';
import '../validation/validators.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp(String firstName, String lastName, String phone, String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //await userCredential.user?.updateDisplayName(firstName);

      final model = UsersModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        userId: userCredential.user?.uid ?? "",
      );

      print(userCredential.user?.uid);

      await FirebaseFirestore.instance
          .collection('userId')
          .doc(userCredential.user?.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'userid': userCredential.user?.uid ?? "",

      });

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OtpPage())
      );

      //await DatabaseService.instance.setUserInformation(model);

    }on FirebaseAuthException catch(e){
      print('FirebaseAuthException: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Failed"),
            content: Text(e.message ?? "An error occurred."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

  }


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final  TextEditingController emailController = TextEditingController();
  final  TextEditingController  firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final  TextEditingController phoneController = TextEditingController();
  final  TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
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
            key: formKey,
            child: ListView(
              children: [
                Container(
                  height: height/5.2,
                  width: double.infinity,
                  child: Image.asset("images/signup.png"),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: firstnameController,
                    decoration: InputDecoration(

                        hintText: " First Name",
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 14
                        ),
                        prefixIcon: Icon(Icons.people_alt_rounded,
                            color: Colors.black45
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
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
                        ),

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "First Name Required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: lastnameController,
                    decoration: InputDecoration(

                      hintText: " Last Name",
                      hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 14
                      ),
                      prefixIcon: Icon(Icons.people_alt_rounded,
                          color: Colors.black45
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
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
                      ),

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Last Name Required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(

                        hintText: " Phone NUmber",
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 14
                        ),
                        prefixIcon: Icon(Icons.phone_in_talk,
                            color: Colors.black45
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
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
                    validator: (val){
                      if(val==null || val.isEmpty){
                        return "Phone Number Required";
                      }
                      else if(validatePhoneNumber(val)){
                        return "Enter a Valid NUmber";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
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
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(

                        hintText: " Password ",
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 14
                        ),
                        prefixIcon: Icon(Icons.lock,
                            color: Colors.black45
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
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
                        return "Password is Required ";
                      }
                      else if(value.length < 8){
                        return "Password must be more than 8 letters ";
                      }
                      else if(!validatePassword(value)){
                        return "Password should contain upper,lower,digit and Special character";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true ,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(

                        hintText: "Re-Enter the Password ",
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 14
                        ),
                        prefixIcon: Icon(Icons.confirmation_num,
                            color: Colors.black45
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
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
                        return "Password is Required";
                      }
                      else if(value != passwordController.text.trim()){
                        return "Password doesn't match ";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30,),
                MyButton(onTap: (){
                  final isValid = formKey.currentState?.validate() ?? false;
                  if (!isValid) return;

                  _signUp(
                    firstnameController.text.trim(),
                    lastnameController.text.trim(),
                    phoneController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim()
                      );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));

                }, text: "Sign Up"),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ",
                      style:TextStyle(
                          fontSize: 16
                      ) ,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: const Text("Log In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    )

                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

