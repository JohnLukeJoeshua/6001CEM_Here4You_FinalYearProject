import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import 'Wellness_Submit_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class daily_wellness extends StatefulWidget {
  const daily_wellness({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<daily_wellness> createState() => _daily_wellnessState();
}

class _daily_wellnessState extends State<daily_wellness> {
  double h = 0;
  double w = 0;

  //final dbHelper = DatabaseHelper();
  DateTime Now = DateTime.now();
  String formattedDate = "";
  List DailywellnessFirebase = [];
  List ChartFirebase = [];
  List Dailywellness = [];
  Map Data = {};
  Map Data1 = {};
  List Chart = [];
  int Selected = 0;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState

    // Enable analytics collection
    analytics.setAnalyticsCollectionEnabled(true);

    // Log a custom event for tracking pages
    logPageView("daily_wellness");

    super.initState();
    SetDateAnndQuition();
  }

  void logPageView(String daily_wellness) {
    analytics.logEvent(name: daily_wellness);
  }

  @override
  SetDateAnndQuition() async {
    formattedDate = DateFormat('dd-MM-yyyy').format(Now);
    Dailywellness = await Firestore.Get_Wellness();
    Chart = await Firestore.Get_Chart();

    Dailywellness.forEach((element) {
      if (element['Date'] == formattedDate) {
        Data = element;
        Selected = element['DailyQ'];
      }
    });
    Chart.forEach((element) {
      if (element['Date'] == formattedDate) {
        Data1 = element;
      }
    });
    if (mounted) {
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              color: AppColor.Backgroundthem,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // dbHelper.insertItem(formattedDate, 6);
                  },
                  child: AppIcon.Back),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wellness Check-In",
                    style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
              Con_widget.Space(h: 5, w: w),
              Container(
                margin: EdgeInsets.symmetric(vertical: 80),
                child: Column(children: [
                  Text(
                    "How are you feeling today? ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.white),
                  ),
                  Con_widget.Space(h: 20, w: w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () async {
                            if (Data['DailyQ'] == 0) {
                              setState(() {
                                Selected = 1;
                              });
                              // dbHelper.updateData(Data['id'],{"DailyQ" : 1});
                              // dbHelper.updateDataChart(Data1['id'],{"DailyQ" : 1});
                              // dbHelper.updateDataAchievements(1, {"Done" : 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Wellness_history",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Chart",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Achievements",
                                  FieldName: "Achievements",
                                  fieldNamevalue:
                                      "Completed the peacefulness questionaire(Mood tracker)",
                                  Data: {"Done": 1});
                              setState(() {});
                            }
                          },
                        child: Column(
                          children: [
                            SizedBox(height: 10),  // Add space between the text and the number
                            Text(
                              "Not Good",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,  // Increase the font size to 14
                                color: Selected == 1 ? AppColor.black : AppColor.white,
                              ),
                            ),
                            SizedBox(height: 10),  // Add more space if needed
                            CircleAvatar(
                              backgroundColor: Selected == 1 ? AppColor.black : AppColor.white,
                              child: Text(
                                "1",
                                style: TextStyle(
                                  color: Selected == 1 ? AppColor.white : AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            if (Data['DailyQ'] == 0) {
                              setState(() {
                                Selected = 2;
                              });
                              // dbHelper.updateData(Data['id'],{"DailyQ" : 2});
                              // dbHelper.updateDataChart(Data1['id'],{"DailyQ" : 2});
                              // dbHelper.updateDataAchievements(1, {"Done" : 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Wellness_history",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 2});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Chart",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 2});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Achievements",
                                  FieldName: "Achievements",
                                  fieldNamevalue:
                                      "Completed the peacefulness questionaire(Mood tracker)",
                                  Data: {"Done": 1});
                              setState(() {});
                            }
                          },
                        child: Column(
                          children: [
                            SizedBox(height: 12),  // Add space between the text and the number
                            Text(
                              "",
                            ),
                            SizedBox(height: 12),  // Add more space if needed
                            CircleAvatar(
                              backgroundColor: Selected == 2 ? AppColor.black : AppColor.white,
                              child: Text(
                                "2",
                                style: TextStyle(
                                  color: Selected == 2 ? AppColor.white : AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            if (Data['DailyQ'] == 0) {
                              setState(() {
                                Selected = 3;
                              });
                              // dbHelper.updateData(Data['id'],{"DailyQ" : 3});
                              // dbHelper.updateDataChart(Data1['id'],{"DailyQ" : 3});
                              // dbHelper.updateDataAchievements(1, {"Done" : 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Wellness_history",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 3});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Chart",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 3});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Achievements",
                                  FieldName: "Achievements",
                                  fieldNamevalue:
                                      "Completed the peacefulness questionaire(Mood tracker)",
                                  Data: {"Done": 1});
                              setState(() {});
                            }
                          },
                        child: Column(
                          children: [
                            SizedBox(height: 12),  // Add space between the text and the number
                            Text(
                              "",
                            ),
                            SizedBox(height: 12),  // Add more space if needed
                            CircleAvatar(
                              backgroundColor: Selected == 3 ? AppColor.black : AppColor.white,
                              child: Text(
                                "3",
                                style: TextStyle(
                                  color: Selected == 3 ? AppColor.white : AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            if (Data['DailyQ'] == 0) {
                              setState(() {
                                Selected = 4;
                              });
                              // dbHelper.updateData(Data['id'],{"DailyQ" : 4});
                              // dbHelper.updateDataChart(Data1['id'],{"DailyQ" : 4});
                              // dbHelper.updateDataAchievements(1, {"Done" : 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Wellness_history",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 4});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Chart",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 4});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Achievements",
                                  FieldName: "Achievements",
                                  fieldNamevalue:
                                      "Completed the peacefulness questionaire(Mood tracker)",
                                  Data: {"Done": 1});
                              setState(() {});
                            }
                          },
                        child: Column(
                          children: [
                            SizedBox(height: 12),  // Add space between the text and the number
                            Text(
                              "",
                            ),
                            SizedBox(height: 12),  // Add more space if needed
                            CircleAvatar(
                              backgroundColor: Selected == 4 ? AppColor.black : AppColor.white,
                              child: Text(
                                "4",
                                style: TextStyle(
                                  color: Selected == 4 ? AppColor.white : AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            if (Data['DailyQ'] == 0) {
                              setState(() {
                                Selected = 5;
                              });
                              // dbHelper.updateData(Data['id'],{"DailyQ" : 5});
                              // dbHelper.updateDataChart(Data1['id'],{"DailyQ" : 5});
                              // dbHelper.updateDataAchievements(1, {"Done" : 1});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Wellness_history",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 5});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Chart",
                                  FieldName: "Date",
                                  fieldNamevalue: Data['Date'],
                                  Data: {"DailyQ": 5});
                              Firestore.findDocumentByFieldValue(
                                  collection: "Achievements",
                                  FieldName: "Achievements",
                                  fieldNamevalue:
                                      "Completed the peacefulness questionaire(Mood tracker)",
                                  Data: {"Done": 1});
                              setState(() {});
                            }
                          },
                        child: Column(
                          children: [
                            SizedBox(height: 10),  // Add space between the text and the number
                            Text(
                              "Good",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,  // Increase the font size of "Not good" to 14
                                color: Selected == 5 ? AppColor.black : AppColor.white,
                              ),
                            ),
                            SizedBox(height: 10),  // Add more space if needed
                            CircleAvatar(
                              backgroundColor: Selected == 5 ? AppColor.black : AppColor.white,
                              child: Text(
                                "5",
                                style: TextStyle(
                                  color: Selected == 5 ? AppColor.white : AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              Spacer(),
              Con_widget.CommonButton(
                textcolor: AppColor.black,
                color: AppColor.white,
                Name: "Submit",
                OnTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Wellness_Sabmit_page();
                    },
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
