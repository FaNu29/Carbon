import 'package:carbon/Event/eventPage.dart';
import 'package:carbon/HomeScreen/HomePg.dart';
import 'package:carbon/Widgets/button.dart';
import 'package:carbon/Widgets/clip_clipper.dart';
import 'package:carbon/Widgets/text_field.dart';
import 'package:carbon/media/social_home_page.dart';
import 'package:carbon/onboarding/forget_password_page.dart';
import 'package:carbon/onboarding/otp_page.dart';
import 'package:carbon/onboarding/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../validation/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userEmail ="";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _signInWithGoogle() async {

    GoogleSignInAccount? googleUser =  await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,

    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);

    if(userCredential.user != null){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Homepg()));
    }

  }

  Future<UserCredential> _signInWithFacebook() async{
    //Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ["email", 'public_profile', 'user_birthday']
    );

    //Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider
        .credential(loginResult.accessToken!.tokenString);

    var userData = await FacebookAuth.instance.getUserData();

    userEmail = userData['email'];

    //Once signed in, return the user credential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);


  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        //backgroundColor: Colors.white,
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFC8FA9C),
        Color(0xFF93A87F),
        Color(0xFF455932),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SafeArea(
          child: Container(
        height: height,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: height / 2.8,
                    width: double.infinity,
                    child: Image.asset("images/login.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "  Email",
                        hintStyle: const TextStyle(
                            color: Colors.black45, fontSize: 14),
                        prefixIcon: Icon(Icons.email, color: Colors.black45),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email Required";
                      } else if (!validateEmailAddress(value)) {
                        return "PLease Enter a valid Email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    //validator: validate,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: " Password",
                        hintStyle: const TextStyle(
                            color: Colors.black45, fontSize: 14),
                        prefixIcon: Icon(Icons.lock, color: Colors.black45),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPasswordPage()));
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final isValid = formKey.currentState?.validate() ?? false;
                    if (!isValid) return;

                    isLoading = true;
                    setState(() {});
                    var loginEmail = emailController.text.trim();
                    var loginPass = passwordController.text.trim();
                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginEmail, password: loginPass))
                          .user;
                      if (firebaseUser != null) {
                        //final user = await DatabaseService.instance.getUserInfo(firebaseUser.uid);
                        isLoading = false;
                        setState(() {});
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Homepg()),
                        );
                      } else {
                        isLoading = false;
                        setState(() {});
                        print("Check Email and password");
                      }
                    } on FirebaseAuthException catch (e) {
                      isLoading = false;
                      setState(() {});
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Authentication Error'),
                            content: Text(e.message ?? 'An error occurred'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
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
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        color: Color(0xFF455932),
                      ),
                      child: InkWell(
                        onTap: (){
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
                const Text("SignUp using\n"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            _signInWithFacebook();
                            setState(() {

                            });

                          },
                          child: Image.asset("images/fb_logo.png")),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                          onTap: () {
                             _signInWithGoogle();
                          },
                          child: Image.asset("images/google_logo.png")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    
                    


                  ],
                ),



              ],
            ),
          ),
        ),
      )),
    ));
  }
}

