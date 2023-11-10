import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Firebase/AuthMethod.dart';
import '../../const/Con_widget.dart';
import '../../const/color_constant.dart';
import 'ForgotPassword.dart';
import 'Sign_up.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool show = true;
  double h = 0;
  bool isLoading = false;
  double w = 0;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffB81736), Color(0xff281537)],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 70.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 18),
                child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      TextField(
                        controller: Email,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.email, color: Colors.grey),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: Password,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            icon: Icon(show ? Icons.visibility : Icons.visibility_off),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        obscureText: show,
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          highlightColor: AppColor.transparent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ForgotPassword();
                            },));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff281537),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30), // Add a 20-pixel gap
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (Email.text.trim().isEmpty) {
                              Con_widget.Tost(BuildContext: context, name: 'Enter valid Email');
                            } else if (Password.text.trim().isEmpty) {
                              Con_widget.Tost(BuildContext: context, name: 'Enter valid Password');
                            } else {

                              // Log an analytics event for the login button click
                              analytics.logEvent(name: 'Sign_In');

                              setState(() {
                                isLoading = true;
                              });
                              if (await AuthMethod.loginEmailUser(email: Email.text, password: Password.text, context: context)) {
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 30), // Add space above "Don't have an account?"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ?",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                highlightColor: AppColor.transparent,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return Sign_up();
                                  }));
                                },
                                child: Text(
                                  ' Sign up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffB81736),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 30), // Add space above the "or continue with" text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    'or continue with',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Con_widget.Space(h: 10, w: 10),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (await AuthMethod.SignInGoogle(context)) {
                            setState(() {
                              isLoading = false;
                            });
                            // Handle successful Google Sign-In, e.g., navigate to the next screen
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            // Handle Google Sign-In failure, show an error message
                          }
                        },
                        icon: Image.asset('assets/Images/google.png'),
                        iconSize: 48,
                        color: Color(0xffB81736),
                      ),
                      Con_widget.Space(h: 60, w: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          )
              : Container(),
          isLoading
              ? Center(
            child: CircularProgressIndicator(color: AppColor.themColor),
          )
              : Container(),
        ],
      ),
    );
  }
}
