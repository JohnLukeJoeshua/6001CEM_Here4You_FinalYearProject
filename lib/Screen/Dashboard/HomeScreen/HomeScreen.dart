import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here4you/Firebase/AuthMethod.dart';
import 'package:here4you/Firebase/Firestore.dart';
import '../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../Sharepref/Sharepref.dart';
import '../../../const/Con_Data.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../Achievements/Achievements.dart';
import '../Explore/Explore.dart';
import '../Notes/Notes.dart';
import 'Home_page.dart';
import '../Profile/Profile.dart';


class Homescreen extends StatefulWidget {
  int? Index;
  Homescreen({this.Index});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  late TabController tabController;
  //final dbHelper = DatabaseHelper();

  DateTime Now = DateTime.now();
  List Achievement = [];
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home_page(),
    Explore(),
    Achievements(),
    Profile(),
    Notes(),
  ];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Con_widget.SetTime();
    _currentIndex = widget.Index ?? 0;
    tabController = TabController(
      initialIndex: _currentIndex,
      length: 5,
      vsync: this,
    );
    AddAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body:TabBarView(
              controller: tabController,
              physics:NeverScrollableScrollPhysics(),children: [
            _screens[0],
            _screens[1],
            _screens[2],
            _screens[4],
            _screens[3],
          ]),
          bottomNavigationBar: Bottombar(),
        ),
      ),), onWillPop: () {

      SystemNavigator. pop();
      return Future(() => true);
      },);
  }
  Widget Bottombar(){
    return TabBar(
      controller: tabController,
      onTap: (value) {
        _currentIndex=value;
        setState(() {
        });
      },
      isScrollable: false,
      unselectedLabelColor: AppColor.grey1,
      labelColor: AppColor.themColor,
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColor.themColor, width: 2),
        ),
      ),
      tabs: [
        Tab(icon: Icon(Icons.other_houses_outlined)),
        Tab(icon: Icon(Icons.search_outlined)),
        Tab(icon: Icon(Icons.star_border_purple500_sharp)),
        Tab(icon: Icon(Icons.note_add)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }
  AddAchievements() async {
     Achievement = await Firestore.Get_Achievment();
     print(Achievement);
    if(Achievement.isEmpty)
      {
        Con_Data.Archivment.forEach((element) {
          // dbHelper.insertItemAchievements(element);
          Firestore.AddAchievements(Achievments: element);
        });
      }
  }
}
