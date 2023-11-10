import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../../Firebase/Firestore.dart';
import '../../../../const/Con_widget.dart';
import '../../../../const/color_constant.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Meditate_Exercise extends StatefulWidget {
  const Meditate_Exercise({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Meditate_Exercise> createState() => _Meditate_ExerciseState();
}

class _Meditate_ExerciseState extends State<Meditate_Exercise> {
  //final dbHelper = DatabaseHelper();
  double h = 0;
  int _countdown = 15 * 60; // 15 minutes in seconds
  late Timer _timer;
  double w = 0;
  bool breathin = false;
  bool text = false;
  double pregrass = 0;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

@override
void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("Meditate_Exercise");

    super.initState();
    AchievementsUpdate();
  }

  void logPageView(String Meditate_Exercise) {
    analytics.logEvent(name: Meditate_Exercise);
  }

  AchievementsUpdate()
  {
    // dbHelper.updateDataAchievements(4,{"Done" : 1});
    Firestore.findDocumentByFieldValue(collection: "Achievements", FieldName: "Achievements", fieldNamevalue: "Completed the 1st guided practice", Data: {"Done" : 1});
  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _startTimer();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          color: AppColor.Backgroundthem,
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: AppIcon.Back),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Clear your mind & Meditate",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                      fontSize: 20),
                )
              ],
            ),
            Con_widget.Space(h: 15, w: w),
            Text(
              "⦁	Using the Meditation guide to help, clear your mind and focus on your breathing. Enjoy the peace and quiet for 15mins without any interruptions",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                  fontSize: 15),
            ),
            Con_widget.Space(h: h / 10, w: w),
            Center(
              child: CircularPercentIndicator(
                radius: h / 6,
                lineWidth: 25,
                backgroundColor: AppColor.white,
                percent: breathin ? 1 : 0,
                animation: true,
                 animationDuration: 1000,
                restartAnimation: true,
                progressColor: AppColor.themColor,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                      color: AppColor.white, fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ),
            ),
            Con_widget.Space(h: 15, w: w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("15 Minutes",
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
                Con_widget.Space(h: 15, w: w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                   setState(() {
                     if(breathin)
                     {
                       _countdown = 15 * 60;
                       breathin=false;
                       _timer.cancel();
                     }else{
                       breathin = true;
                       _startTimer();
                     }
                   });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: w/3,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(breathin ? "Reset" : "Start ",style: TextStyle(color: AppColor.themColor,fontWeight: FontWeight.bold,fontSize: 16)),
                  ),
                ),
                Con_widget.Space(h: 0, w: 10),
                InkWell(
                  onTap: () {
                    breathin=false;
                    _timer.cancel();
                    setState(() {
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: w/3,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Stop",style: TextStyle(color: AppColor.themColor,fontWeight: FontWeight.bold,fontSize: 16)),
                  ),
                )

              ],
            )
          ]),
        ),
      ),
    );
  }
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
}
