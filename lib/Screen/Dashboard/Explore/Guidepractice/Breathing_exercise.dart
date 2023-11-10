import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../../Firebase/Firestore.dart';
import '../../../../const/Con_widget.dart';
import '../../../../const/color_constant.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Brathing_exercise extends StatefulWidget {
  const Brathing_exercise({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Brathing_exercise> createState() => _Brathing_exerciseState();
}

class _Brathing_exerciseState extends State<Brathing_exercise> {
  //final dbHelper = DatabaseHelper();
  double h = 0;
  double w =0;
  bool breathin =false;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("Breathing_exercise");

    super.initState();
    AchievementsUpdate();
  }

  void logPageView(String Breathing_exercise) {
    analytics.logEvent(name: Breathing_exercise);
  }

  AchievementsUpdate()
  {
    // dbHelper.updateDataAchievements(4,{"Done" : 1});
    Firestore.findDocumentByFieldValue(collection: "Achievements", FieldName: "Achievements", fieldNamevalue: "Completed the 1st guided practice", Data: {"Done" : 1});
  }
  Widget build(BuildContext context) {
    h= MediaQuery.of(context).size.height;
    w= MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(10),
          color: AppColor.Backgroundthem,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             TextButton(onPressed: () {
              Navigator.pop(context);
             }, child: AppIcon.Back),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Breathing Exercise",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                          fontSize: 20),
                    )
                  ],
                ),
                 Con_widget.Space(h: 15, w: w),
                breathin ? Container():Text(
                  "⦁ Panic attacks or Stress will come & Go.\n  Control your breathing with the below exercise. ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                      fontSize: 15),
                ),
                Con_widget.Space(h: h / 10, w: w),
                breathin ? Container(
                  child:  Lottie.asset(fit: BoxFit.fill,"assets/Animation/Brething.json"),
                ): Container(),
                Con_widget.Space(h: 20, w: w),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  InkWell(
                    onTap: () {
                      breathin=!breathin;
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
                      child: Text(breathin ? "Stop" : "Start ",style: TextStyle(color: AppColor.themColor,fontWeight: FontWeight.bold,fontSize: 16)),
                    ),
                  ),
                ],)
          ]),
        ),
      ),
    );
  }
}
