import 'dart:async';
import 'package:flutter/material.dart';
import '../../const/Con_widget.dart';
import '../../const/color_constant.dart';
import '../Dashboard/HomeScreen/HomeScreen.dart';

class Relaxation extends StatefulWidget {
  const Relaxation({super.key});

  @override
  State<Relaxation> createState() => _RelaxationState();
}

class _RelaxationState extends State<Relaxation> {
  double h = 0;
  double w=0;
  bool Comdown=false;
  late Timer _timer;
  int Second= 5;

  @override
  Widget build(BuildContext context) {
    h=MediaQuery.of(context).size.height;
    w=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(height: h,width: w,
            decoration: BoxDecoration(image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/Images/Background2.jpg'))),
          child: Comdown ? Column(children: [
            Padding(
              padding: EdgeInsets.only(top: h/5,left: w/5,right: w/5,bottom: h/5),
              child: Container(
                child: Text("For the next 5 seconds focus on your breathing",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.black)),
              ),
            ),
            Text("${Second}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: AppColor.black))
          ],):Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: h/3.5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("${Second} second",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColor.black))
                  ],),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("To tap into your",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColor.black))
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("inner peace",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColor.black))
                ],),
                Padding(padding: EdgeInsets.only(top: 20),child: Con_widget.CommonButton(color: AppColor.white,textcolor: AppColor.black,Name: "Continue", OnTap: () {
                  Comdown=true;
                  _startCountdown();
                  setState(() {
                  });
                },),)
          ]),
        ),
      ),
    );
  }
  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Second > 0) {
          Second--;
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Homescreen();
          },));
          _timer.cancel(); // Stop the countdown when it reaches 0.
        }
      });
    });
  }
}
