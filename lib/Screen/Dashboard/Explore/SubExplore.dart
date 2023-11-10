
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here4you/DatabaseHelper/DatabaseHelper.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:here4you/Screen/Dashboard/Explore/Guidepractice/Breathing_exercise.dart';
import 'package:here4you/Screen/Dashboard/Explore/Guidepractice/Meditate_Exercise.dart';
import 'package:here4you/Screen/Dashboard/Explore/instruction.dart';
import 'package:here4you/Screen/Dashboard/HomeScreen/HomeScreen.dart';
import 'package:here4you/const/Con_Data.dart';
import 'package:here4you/const/color_constant.dart';

class SubExplore extends StatefulWidget {
  String CoursesName;
  String docid;
  SubExplore({required this.CoursesName,required this.docid});

  @override
  State<SubExplore> createState() => _SubExploreState();
}

class _SubExploreState extends State<SubExplore> {
  double h = 0;
  double w =0;
  String id = "";
  List Fav = [];
  //final dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    GetData();
  }

  GetData()
  async {
    Fav = await Firestore.Get_Fav();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    h= MediaQuery.of(context).size.height;
    w= MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Homescreen(Index: 1,);
        },));
        return Future(() => true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: h,
            width: w,
            padding: EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return Homescreen(Index: 1,);
                        },));
                        // dbHelper.insertItem(formattedDate, 6);
                      },
                      child: AppIcon.Back),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Courses",style: TextStyle(color:AppColor.black,fontWeight: FontWeight.w500,fontSize: 30)),
                  ),
                 Expanded(
                   child: FutureBuilder<DocumentSnapshot>(
                   future: FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).collection(widget.CoursesName).doc(widget.docid).get(),
                   builder: (context, snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return Center(child: CircularProgressIndicator());
                     }
                     if (snapshot.hasError) {
                       return Center(child: Text('Error: ${snapshot.error}'));
                     }
                     if (snapshot.hasData) {
                       var data = snapshot.data?.data() as Map<String, dynamic>;
                       if (data.containsKey('Courses')) {
                         List<dynamic> courses = data['Courses'];
                         return  GridView.builder(
                           physics: BouncingScrollPhysics(),
                           scrollDirection: Axis.vertical,
                           padding: EdgeInsets.only(right: 10,left: 10),
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2, // Number of columns
                               crossAxisSpacing: 10,
                               mainAxisSpacing: 10,
                               childAspectRatio: 0.8
                           ),
                           itemCount:courses.length, // Total number of items in the grid
                           itemBuilder: (BuildContext context, int index) {
                             return InkWell(
                               highlightColor: AppColor.transparent,
                               onTap: () async {
                                 if(courses[index]=="Breathin Exercise"){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                     return Brathing_exercise();
                                   },));
                                 }else if(courses[index]=="Meditate Exercise")
                                 {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                     return Meditate_Exercise();
                                   },));
                                 }else{
                                   String id = await Data(courses[index]);
                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                     return instruction(
                                       CoursesName: widget.CoursesName,
                                       name: courses[index],
                                       Coursesid: widget.docid,
                                       docid: id,
                                     );
                                   },));
                                 }
                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   color: AppColor.black,borderRadius: BorderRadius.all(Radius.circular(10)),
                                   image: DecorationImage(
                                       fit: BoxFit.cover,
                                       image: AssetImage(AppAsset.MeditationImage[index])),
                                 ),
                                 child: Column(children: [
                                   Row(mainAxisAlignment: MainAxisAlignment.end,
                                       children: [
                                         Padding(padding: EdgeInsets.all(5),child:
                                         InkWell(onTap: () {
                                           if(Fav.where((element) => element['CourceName']==courses[index]).isEmpty)
                                           {
                                             // dbHelper.insertItemFav(courses[index],AppAsset.MeditationImage[index].toString(),widget.CoursesName);
                                               Firestore.AddFav(cource: courses[index], Imagename: AppAsset.MeditationImage[index], mainCource: widget.CoursesName);
                                             GetData();
                                           }else{
                                             // dbHelper.deleteDataFav(Fav.firstWhere((element) => element['CourceName']==courses[index])['id']);
                                             GetData();
                                           }

                                           GetData();
                                         },
                                             child:  Fav.where((element) => element['CourceName']==courses[index]).isEmpty ?  AppIcon.Addlike : AppIcon.like),)
                                       ]),
                                   Spacer(),
                                   Container(
                                     alignment: Alignment.center,
                                     height: 20,
                                     width: w,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                         color: AppColor.white.withOpacity(0.6)),
                                     child: Text("${courses[index]}",
                                       style: TextStyle(fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                           color: AppColor.black),),
                                   ),
                                   // Text("${Con_Data.Guided_practice[index]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black),)
                                 ]),
                               ),
                             );
                           },
                         );
                       }

                     }
                     return Text('No data found');
                   },
                 ),),
                ]),
          ),
        ),
      ),
    );
  }
  Future<String>Data(String name)
  async {
    CollectionReference collection = FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).collection(widget.CoursesName).doc(widget.docid).collection(name);
    QuerySnapshot querySnapshot = await collection.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      return doc.id; // This is the document ID
    }
    return "";
  }
}
