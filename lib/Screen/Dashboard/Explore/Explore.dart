import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here4you/Screen/Dashboard/Explore/SubExplore.dart';
import 'package:here4you/const/Con_Data.dart';
import 'package:here4you/const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';
import 'Guidepractice/Guidedpractice.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  TextEditingController search = TextEditingController();
  double h =0;
  double w=0;
  int selectedlen=0;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dd = [];
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Container(
            height: h,
            width: w,
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return Homescreen(Index: 0,);
                        },));
                      },
                      child: AppIcon.Back),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Explore",style: TextStyle(color:AppColor.black,fontWeight: FontWeight.w500,fontSize: 30)),
                  ),
                  Expanded(child:  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).get(),
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

                          // Process and display the courses data
                          return ListView.builder(
                            itemCount: courses.length,
                            itemBuilder: (context, index) {
                              var course = courses[index] as Map<String, dynamic>;
                              return InkWell(onTap: () async {
                                if(course['Courses'] != "0")
                                  {
                                    String id = await Data(course['Name']);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return SubExplore(CoursesName: course['Name'],docid: id,);
                                  },));
                                  }else{
                                  Con_widget.Tost(BuildContext: context, name: "No Courses");
                                }
                              },
                                child: Container(
                                  height: h/3.5,width: w,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(AppAsset.MeditationImage[index])),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(course['Name'].toString(),style: TextStyle(color:AppColor.black,fontWeight: FontWeight.bold,fontSize: 20)),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: h/20,width: w/3,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                                          child: Text("${course['Courses'].toString()} Courses",style: TextStyle(fontWeight: FontWeight.bold,)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                      return Text('No data found');
                    },
                  ),)
            ]),
          ),
      ),
    );
  }
  Future<String>Data(String name)
  async {
    CollectionReference collection = FirebaseFirestore.instance.collection('Courses').doc(Con_Data.DocidCourses).collection(name);
    QuerySnapshot querySnapshot = await collection.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      return doc.id; // This is the document ID
    }
    return "";
  }
}
