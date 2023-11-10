import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../Firebase/AuthMethod.dart';
import '../../../Firebase/Firestore.dart';
import '../../../Sharepref/Sharepref.dart';
import '../../../const/Con_widget.dart';
import '../../../const/Constant_usermast.dart';
import '../../../const/Switch_button.dart';
import '../../../const/color_constant.dart';
import '../../Log_in_pages/Sign_in.dart';
import '../HomeScreen/HomeScreen.dart';
import 'Edit_profile.dart';
import 'Help.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final dbHelper = DatabaseHelper();

  double h = 0;
  double w = 0;
  List Dailywellness = [];
  List Chart = [];
  List Achievement = [];
  List Fav = [];
  List Note = [];
  bool dailyreminder = true;
  bool Email = true;
  String ImageFile="";

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }

  GetData() async {
    Dailywellness = await Firestore.Get_Wellness();
    print("Daily=====$Dailywellness");
    // Chart = await dbHelper.getAllItemschart();
    // print("chart=====$Chart");
    // Achievement = await dbHelper.getAllItemsAchievements();
    // print("achiv=====$Achievement");
    // Note = await dbHelper.getAllItemsNote();
    // print("NOTE=====$Note");
    // Fav = await dbHelper.getAllItemsFav();
    // print("fAV=====$Fav");
    ImageFile = await SharedPref.read_string(SrdPrefkey.Profileimage) ?? "";
    setState(() {});
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
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Homescreen(Index: 0,);
                },));
              },
              child: AppIcon.Back),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Help();
                    },));
                  },
                  child: AppIcon.help)
            ],
          ),
          Text(
            "Profile",
            style: TextStyle(fontSize: h / 20,fontWeight: FontWeight.bold),
          ),
          Con_widget.Space(h: h / 20, w: w),
          Row(
            children: [
              Expanded(flex: 3,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${Constants_Usermast.Name}",
                    style: TextStyle(fontSize: h / 50, color: AppColor.black),
                  ),
                  Text(
                    "streak : ${Dailywellness.length} days",
                    style: TextStyle(fontSize: h / 50, color: AppColor.black),
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: h/10,
                    width: w/5,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:ImageFile.isEmpty ? DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAsset.person) ) : DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(base64Decode(ImageFile)) ))),
                ],
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    Edit_profile(),));
              },
                  child: AppIcon.Edit)
            ],
          ),
          Text(
            "Settings",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
          Con_widget.Space(h: 20, w: w),
          Text(
            "Notification",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
          ),
          Con_widget.Space(h: 10, w: w),
          Row(children: [
            Text("Send me daily reminders",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
            Spacer(),
            CustomSwitch(
              value: dailyreminder,
              onChanged: (bool val){
                setState(() {
                  dailyreminder = val;
                });
              },
            ),
          ],),
          Con_widget.Space(h: 20, w: w),
          Row(children: [
            Text("Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
          ],),
          Con_widget.Space(h: 10, w: w),
          Text("${Constants_Usermast.Email}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
          Con_widget.Space(h: 10, w: w),
          Row(children: [
            Text("Account Active",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
            Spacer(),
            CustomSwitch(
              value: Email,
              onChanged: (bool val){
                setState(() {
                  Email = val;
                });
              },
            ),
          ],),
          Spacer(),
          Con_widget.CommonButton(Name: "Sign out", color: AppColor.Backgroundthem, textcolor: AppColor.white, OnTap: ()  {
            _showLogoutDialog(context);
          },),
          Con_widget.CommonButton(Name: "Delete Account", color: AppColor.Backgroundthem, textcolor: AppColor.white, OnTap: () {
            _showLogoutDialog1(context);
          },),
        ]),
      ),
    ));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Log Out"),
          content: Text("Are you sure you want to Sign out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {

                // Log an analytics event for the Sign Out button click
                analytics.logEvent(name: 'Sign_Out');

                // await Firestore.deleteAllWellness();
                // await Firestore.deleteAllFav();
                // await Firestore.deleteAllNote();
                // await Firestore.deleteAllChart();
                // await Firestore.deleteAllAchivements();
                //   dbHelper.DeleteAllData();
                  AuthMethod.Logout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Sign_in();
                  },));
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
  void _showLogoutDialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Log Out"),
          content: Text("Are you sure you want to Delete Account?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child:Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                // dbHelper.DeleteAllData();
                await AuthMethod.Delete();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Sign_in();
                },));
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

