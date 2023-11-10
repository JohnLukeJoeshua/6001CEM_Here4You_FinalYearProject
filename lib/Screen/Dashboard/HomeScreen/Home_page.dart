import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:here4you/Screen/Dashboard/Explore/Guidepractice/Breathing_exercise.dart';
import 'package:here4you/Screen/Dashboard/Explore/Guidepractice/Meditate_Exercise.dart';
import 'package:here4you/Screen/Dashboard/Explore/instruction.dart';
import 'package:here4you/const/Con_Data.dart';
import 'package:intl/intl.dart';
import '../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../const/Con_widget.dart';
import '../../../const/Constant_usermast.dart';
import '../../../const/color_constant.dart';
import 'Favorites.dart';
import 'daily_wellness.dart';
import 'package:here4you/widget/motivation_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  //final dbHelper = DatabaseHelper();
  double h = 0;
  String formattedDate = "";
  double w = 0;
  DateTime Now = DateTime.now();
  List Dailywellness = [];
  List Achievements = [];
  List Fav = [];
  List Chart = [];
  bool loading =false;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState

    // Enable analytics collection
    analytics.setAnalyticsCollectionEnabled(true);

    // Log a custom event for tracking pages
    logPageView("Home_page");

    super.initState();
    SetDateAnndQuition();
  }

  void logPageView(String Home_page) {
    analytics.logEvent(name: Home_page);
  }

  SetDateAnndQuition() async {
    formattedDate = DateFormat('dd-MM-yyyy').format(Now);
    Dailywellness = await Firestore.Get_Wellness();
    Fav = await Firestore.Get_Fav();
    Achievements = await Firestore.Get_Achievment();
    Chart = await Firestore.Get_Chart();
    setState(() {
      loading = true;
    });
  if(Dailywellness.isNotEmpty)
    {
      print(Dailywellness);
      if(Dailywellness.where((element) => element['Date']==formattedDate).isEmpty)
        {
          print("THise Data add");
          print("THise Data add");
          Firestore.AddWellNess_history(Date: formattedDate,Daily:0);
          await Firestore.AddChart(Date: formattedDate,Daily:0,id: Chart.length+1);
        }else{
        print("Hello");
      }
    }else{
    Firestore.AddWellNess_history(Date: formattedDate,Daily:0);
    await Firestore.AddChart(Date: formattedDate,Daily:0,id: 0);
    Achievements.forEach((element) {
      Firestore.findDocumentByFieldValue(collection: "Achievements", FieldName: "Achievements", fieldNamevalue: element['Achievements'], Data: {"Done" : 0});
    });
  }
    if (Chart.length > 6) {
      await Firestore.deleteAllChart();
      await Firestore.AddChart(Date: formattedDate,Daily:0,id: 0);
    }
    if(Dailywellness.length > 7)
      {
        Firestore.findDocumentByFieldValue(collection: "Achievements", FieldName: "Achievements", fieldNamevalue: "Completed 7 days of peacefulness streak", Data: {"Done" : 1});
      }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      child: Stack(children: [
        Container(
          height: h / 3,
          width: w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppAsset.one))),
        ),
        Padding(
          padding: EdgeInsets.only(top: h / 3.5),
          child: Container(
            padding: EdgeInsets.all(5),
            width: w,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " Hi, ${Constants_Usermast.Name}",
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),

                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Favorites();
                          },
                        ));
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColor.Backgroundthem,
                        child: AppIcon.addfav,
                        maxRadius: 18,
                      ))
                ],
              ),
              Con_widget.CommonButton(
                Name: "How are you feeling today? ",
                color: AppColor.Backgroundthem,
                textcolor: AppColor.black,
                OnTap: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return daily_wellness();
                    },
                  ));
                },
              ),
              Spacer(),
                  MotivationWidget(),
              Spacer(),
              Text(" Favourite",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              Container(
                height: h / 7,
                margin: EdgeInsets.all(10),
                child: Fav.isNotEmpty
                    ? GridView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 10, left: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // Number of columns
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8),
                        itemCount: Fav.length,
                        // Total number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              if(Fav[index]['CourceName']=="Breathin Exercise"){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Brathing_exercise();
                                },));
                              }else if(Fav[index]['CourceName']=="Meditate Exercise")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Meditate_Exercise();
                                },));
                              }else{
                                String Courceid = await mainCourceid(Fav[index]['Cource']);
                                String id = await Data(Fav[index]['CourceName'],Fav[index]['Cource'],Courceid);
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return instruction(
                                    CoursesName: Fav[index]['Cource'],
                                    name: Fav[index]['CourceName'],
                                    Coursesid: Courceid,
                                    docid: id,
                                  );
                                },));
                              }
                            },
                            highlightColor: AppColor.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(Fav[index]['ImageName']))),
                              child: Column(children: [
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: AppColor.white.withOpacity(0.6)),
                                  child: Text(
                                    "${Fav[index]['CourceName']}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      )
                    :   loading ? Center(
                        child: Image.asset(
                        AppAsset.Nodata,
                        fit: BoxFit.fill,
                      )) : Center(child: CircularProgressIndicator(color: AppColor.black,)),
              ),
            ]),
          ),
        )
      ]),
    );
  }
  Future<String>Data(String name,String Courcename,String docid)
  async {
    CollectionReference collection = FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).collection(Courcename).doc(docid).collection(name);
    QuerySnapshot querySnapshot = await collection.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      return doc.id; // This is the document ID
    }
    return "";
  }
  Future<String>mainCourceid(String name)
  async {
    CollectionReference collection = FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).collection(name);
    QuerySnapshot querySnapshot = await collection.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      return doc.id; // This is the document ID
    }
    return "";
  }
}
