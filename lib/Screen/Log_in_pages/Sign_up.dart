import 'package:flutter/material.dart';
import '../../Firebase/AuthMethod.dart';
import '../../const/Con_widget.dart';
import '../../const/color_constant.dart';
import 'Loading.dart';
import 'Sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}


class _Sign_upState extends State<Sign_up> {
  TextEditingController Name = TextEditingController();
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

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB81736),
                    Color(0xff281537),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Con_widget.textfield(controller: Name, hintText: 'Full Name'),
                        Con_widget.textfield(controller: Email, hintText: 'Email'),
                        Con_widget.textfield(
                          controller: Password,
                          hintText: 'Password',
                          obscureText: show,
                          suffixIcon: IconButton(
                            color: AppColor.grey1,
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            icon: Icon(show ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 40),

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
                              if (Name.text.trim().isEmpty) {
                                Con_widget.Tost(BuildContext: context, name: 'Enter the Name');
                              } else if (Email.text.trim().isEmpty) {
                                Con_widget.Tost(BuildContext: context, name: 'Enter the Email');
                              } else if (Password.text.isEmpty) {
                                Con_widget.Tost(BuildContext: context, name: 'Enter the Password');
                              } else {

                                // Log an analytics event for the login button click
                                analytics.logEvent(name: 'Sign_Up');

                                setState(() {
                                  isLoading = true;
                                });
                                if (await AuthMethod.signUpUser(
                                  email: Email.text,
                                  password: Password.text,
                                  context: context,
                                  name: Name.text,
                                )) {
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
                                'SIGN UP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                highlightColor: AppColor.transparent,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return Sign_in();
                                  }));
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
