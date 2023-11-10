import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here4you/const/Con_Data.dart';
import 'package:here4you/const/Con_widget.dart';
import 'package:here4you/const/color_constant.dart';

import '../../../Firebase/Firestore.dart';

class instruction extends StatefulWidget {
  String CoursesName;
  String name;
  String Coursesid;
  String docid;
  instruction({required this.CoursesName,required this.Coursesid,required this.docid,required this.name});

  @override
  State<instruction> createState() => _instructionState();
}

class _instructionState extends State<instruction> {
  double h = 0;
  double w = 0;
  //final dbHelper = DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AchievementsUpdate();
  }
  AchievementsUpdate()
  {
    // dbHelper.updateDataAchievements(3,{"Done" : 1});
    Firestore.findDocumentByFieldValue(collection: "Achievements", FieldName: "Achievements", fieldNamevalue: "Completed the 1st resource content", Data: {"Done" : 1});
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          color: AppColor.Backgroundthem,
          padding: EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).collection(widget.CoursesName).doc(widget.Coursesid).collection(widget.name).doc(widget.docid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: AppColor.white,));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                var data = snapshot.data?.data() as Map<String, dynamic>;
                String Title = data['Title'];
                String Subtitle = data['Subtitle'];
                if (data.containsKey('Data')) {
                  List<dynamic> courses = data['Data'];
                  print(courses);
                  // Process and display the courses data
                  return  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Row(children: [
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_outlined,color: AppColor.white,)),
                    ],),
                    Con_widget.Space(h: 20, w: w),
                    Text(
                      "${Title}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white),
                    ),
                    Con_widget.Space(h: 20, w: w),
                    Text(
                      Subtitle,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.white),
                    ),
                    Con_widget.Space(h: 20, w: w),
                    Expanded(child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                          width: w,
                          decoration: BoxDecoration(color: AppColor.white,borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index+1}.${courses[index]['Title']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black),
                                ),
                                Con_widget.Space(h: h*0.02, w: w),
                                Text(
                                  "${courses[index]['Subtitle']}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.grey1),
                                )
                              ]),
                        );
                      },
                    ))
                  ]);
                }

              }
              return Text('No data found');
            },
          ),),
        ),
    );
  }
}
