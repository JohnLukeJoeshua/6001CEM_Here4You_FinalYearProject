import 'dart:math';
import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';
import 'AddNote.dart';
import 'Noteshow.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Notes> createState() => _NotesState();
}
class _NotesState extends State<Notes> {
  double h = 0;
  double w = 0;
  //final dbHelper = DatabaseHelper();
  DateTime Now=DateTime.now();
  List Notes = [];
  bool NoteData =false;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("Notes");

    super.initState();
    GetNote();
  }

  void logPageView(String Notes) {
    analytics.logEvent(name: Notes);
  }

  GetNote()
  async {
    Notes = await Firestore.Get_Note();
    NoteData =true;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton:  FloatingActionButton(
        backgroundColor: AppColor.white, onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return AddNote();
          },));
        },child: AppIcon.Addnote,),
        body: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              color: AppColor.Backgroundthem,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Homescreen(Index: 0,);
                      },));
                      // Navigator.pop(context);
                      // dbHelper.insertItem(formattedDate, 6);
                    },
                    child: AppIcon.Back),
                Text("Journal Entries",style: TextStyle(fontSize: 24,color: AppColor.white,fontWeight: FontWeight.bold),)
              ],),
              Con_widget.Space(h: 20, w: w),
              Expanded(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:Notes.isEmpty ?
                NoteData ?
                Center(child: Center(child: Text("Please Add Your Note......",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 16),)),)
                   : Center(child: CircularProgressIndicator(color: AppColor.white),) : GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.75,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 200,
                      mainAxisSpacing: 10),
                  itemCount: Notes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Noteshow(Notes[index]);
                          },));
                      },
                      child: Card(
                        color: AppColor.white,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                           Padding(
                             padding: const EdgeInsets.all(15),
                             child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                               Text(
                                 Notes[index]['title'],
                                 style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black),
                               )
                             ],),
                           ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text(
                                Notes[index]['Description'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                                Text(
                                  formatDate(Notes[index]['Date']),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              ],),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
  formatDate(String inputDate) {
    // Parse the input date in the original format
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(inputDate);
    // Format the date in the desired format
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }
  getRandomcolor() {
    Random random = Random();
    return colors[random.nextInt(colors.length)];
  }
  List<Color> colors = [
    Colors.pink.shade100,
    Colors.blue.shade100,
    Colors.red.shade50,
    Colors.green.shade100
  ];
}
