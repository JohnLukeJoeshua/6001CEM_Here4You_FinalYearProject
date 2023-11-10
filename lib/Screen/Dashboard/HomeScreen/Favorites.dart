import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import '../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../const/Con_Data.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../Explore/Guidepractice/Breathing_exercise.dart';
import '../Explore/Guidepractice/Meditate_Exercise.dart';
import '../Explore/instruction.dart';
import 'HomeScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  //final dbHelper = DatabaseHelper();
  double h = 0;
  double w = 0;
  List Fav = [];
  bool FavData = false;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("Favorites");

    super.initState();
    Getdata();
  }

  void logPageView(String Favorites) {
    analytics.logEvent(name: Favorites);
  }

  Getdata() async {
    Fav = await Firestore.Get_Fav();
    FavData = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery
        .of(context)
        .size
        .height;
    w = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              color: AppColor.Backgroundthem,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) {
                      return Homescreen();
                    },));
                    // dbHelper.insertItem(formattedDate, 6);
                  },
                  child: AppIcon.Back),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Favorites",
                    style: TextStyle(color: AppColor.white, fontSize: 30),
                  )
                ],
              ),
              Con_widget.Space(h: 15, w: w),
              Expanded(child: Fav.isNotEmpty ?

              GridView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(right: 10, left: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8
                ),
                itemCount: Fav.length,
                // Total number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    highlightColor: AppColor.transparent,
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.black, borderRadius: BorderRadius.all(
                          Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                Fav[index]['ImageName'])),
                      ),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(padding: EdgeInsets.all(5), child:
                              InkWell(onTap: () {
                                Firestore.DeleteMethod(collection: "Favorite", FieldName: "CourceName", fieldNamevalue: Fav[index]['CourceName']);
                                // dbHelper.deleteDataFav(Fav[index]['id']);
                                Getdata();
                                setState(() {});
                                // dbHelper.insertItemFav(Con_Data.Peacefulness_courses[index],AppAsset.MeditationImage[index].toString());
                              },
                                  child: AppIcon.like),)
                            ]),
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
                          child: Text("${Fav[index]['CourceName']}",
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black),),
                        ),
                      ]),
                    ),
                  );
                },
              ) : FavData ? Center(child: Text("No Data in Favorite",
                  style: TextStyle(color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),) : Center(child: CircularProgressIndicator(color: AppColor.white),))
            ],),
        ),
      ),
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
