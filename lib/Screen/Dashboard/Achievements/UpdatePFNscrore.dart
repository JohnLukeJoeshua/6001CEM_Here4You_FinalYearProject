import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';

class UpdatePFNscrore extends StatefulWidget {
  const UpdatePFNscrore({super.key});

  @override
  State<UpdatePFNscrore> createState() => _UpdatePFNscroreState();
}

class _UpdatePFNscroreState extends State<UpdatePFNscrore> {
  double h = 0;
  double w = 0;

  //final dbHelper = DatabaseHelper();
  DateTime Now = DateTime.now();
  String formattedDate = "";
  List Dailywellness = [];
  List Chart = [];
  Map Data = {};
  Map Data1 = {};
  int Selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetDateAnndQuition();
  }

  SetDateAnndQuition() async {
    formattedDate = DateFormat('dd-MM-yyyy').format(Now);
    // Dailywellness = await dbHelper.getAllItems();
    // Chart = await dbHelper.getAllItemschart();
    Dailywellness = await Firestore.Get_Wellness();
    Chart = await await Firestore.Get_Chart();
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Homescreen(
              Index: 2,
            );
          },
        ));
        return Future(() => true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
                color: AppColor.Backgroundthem,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Homescreen(
                            Index: 2,
                          );
                        },
                      ));
                    },
                    child: AppIcon.Back),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Wellness Check-In",
                      style: TextStyle(color: AppColor.white, fontSize: 30),
                    )
                  ],
                ),
                Con_widget.Space(h: 15, w: w),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(children: [
                    Text(
                      "How are you felling Today",
                      style: TextStyle(fontSize: 18, color: AppColor.white),
                    ),
                    Con_widget.Space(h: 10, w: w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () async {
                              setState(() {
                                Selected = 1;
                              });
                              // dbHelper.updateData(Data['id'], {"DailyQ": 1});
                              // dbHelper.updateDataChart(Data1['id'], {"DailyQ": 1});
                              // dbHelper.updateDataAchievements(1, {"Done": 1});
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
                            },
                            child: CircleAvatar(
                                backgroundColor: Selected == 1
                                    ? AppColor.black
                                    : AppColor.white,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      color: Selected == 1
                                          ? AppColor.white
                                          : AppColor.black),
                                ))),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                Selected = 2;
                              });
                              // dbHelper.updateData(Data['id'], {"DailyQ": 2});
                              // dbHelper.updateDataChart(Data1['id'], {"DailyQ": 2});
                              // dbHelper.updateDataAchievements(1, {"Done": 1});
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
                            },
                            child: CircleAvatar(
                                backgroundColor: Selected == 2
                                    ? AppColor.black
                                    : AppColor.white,
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      color: Selected == 2
                                          ? AppColor.white
                                          : AppColor.black),
                                ))),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                Selected = 3;
                              });
                              //
                              // dbHelper.updateData(Data['id'], {"DailyQ": 3});
                              // dbHelper.updateDataChart(Data1['id'], {"DailyQ": 3});
                              // dbHelper.updateDataAchievements(1, {"Done": 1});
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
                            },
                            child: CircleAvatar(
                                backgroundColor: Selected == 3
                                    ? AppColor.black
                                    : AppColor.white,
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      color: Selected == 3
                                          ? AppColor.white
                                          : AppColor.black),
                                ))),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                Selected = 4;
                              });
                              // dbHelper.updateData(Data['id'], {"DailyQ": 4});
                              // dbHelper.updateDataChart(Data1['id'], {"DailyQ": 4});
                              // dbHelper.updateDataAchievements(1, {"Done": 1});
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
                            },
                            child: CircleAvatar(
                                backgroundColor: Selected == 4
                                    ? AppColor.black
                                    : AppColor.white,
                                child: Text(
                                  "4",
                                  style: TextStyle(
                                      color: Selected == 4
                                          ? AppColor.white
                                          : AppColor.black),
                                ))),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                Selected = 5;
                              });
                              // dbHelper.updateData(Data['id'], {"DailyQ": 5});
                              // dbHelper.updateDataChart(Data1['id'], {"DailyQ": 5});
                              // dbHelper.updateDataAchievements(1, {"Done": 1});
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
                            },
                            child: CircleAvatar(
                                backgroundColor: Selected == 5
                                    ? AppColor.black
                                    : AppColor.white,
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      color: Selected == 5
                                          ? AppColor.white
                                          : AppColor.black),
                                ))),
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Homescreen(
                        Index: 2,
                      );
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
