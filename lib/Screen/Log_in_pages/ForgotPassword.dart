import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../Firebase/AuthMethod.dart';
import '../../const/Con_widget.dart';
import '../../const/color_constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  double h = 0;
  double w = 0;
  TextEditingController email =TextEditingController();

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Row(children: [
            InkWell(onTap: () {
              Navigator.pop(context);
            },child: AppIcon.Back),
            Con_widget.Space(h: 1, w: 20),
            Text("Reset Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.black),)
          ],),
          Con_widget.Space(h: 20, w: w),
          Con_widget.textfield(controller: email, hintText: "Enter Email"),
          Con_widget.Space(h: 20, w: w),
          Con_widget.Next(Name: "Reset Password", OnTap: () async {
            if(email.text.isNotEmpty)
              {
                if(await AuthMethod.ResetPassword(email: email.text)){
                  Con_widget.Tost(BuildContext: context, name: "Password change request send your Email");
                  Navigator.pop(context);
                }else{
                  Navigator.pop(context);
                }
              }else{

              // Log an analytics event for the login button click
              analytics.logEvent(name: 'ForgotPassword');

              Con_widget.Tost(BuildContext: context, name: "Enter Valid Email");
            }
          },)
        ]),
      ),
    ));
  }
}
