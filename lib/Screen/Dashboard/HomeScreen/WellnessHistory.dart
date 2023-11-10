import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class WellnessHistory extends StatefulWidget {
  const WellnessHistory({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<WellnessHistory> createState() => _WellnessHistoryState();
}

class _WellnessHistoryState extends State<WellnessHistory> {
  double h=0;
  double w=0;
  //final dbHelper = DatabaseHelper();
  List Wellness=[];

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

@override
  void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("WellnessHistory");

    super.initState();
    GetData();
}

  void logPageView(String WellnessHistory) {
    analytics.logEvent(name: WellnessHistory);
  }

GetData()
async {
  Wellness = await Firestore.Get_Wellness();
  Wellness.sort((a, b) {
    final DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateA = format.parse(a["Date"]);
    DateTime dateB = format.parse(b["Date"]);
    return dateA.compareTo(dateB);
  });
  setState(() {
  });
}
  @override
  Widget build(BuildContext context) {
    h=MediaQuery.of(context).size.height;
    w=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(5),
          color: AppColor.Backgroundthem,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(onTap: () {
                  Navigator.pop(context);
                },
                    child: Icon(Icons.arrow_back_outlined,color: AppColor.white,size: 30,)),
              ),
            ]),
            Con_widget.Space(h: 10, w: w),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Wellness History",style: TextStyle(fontSize: 20,color: AppColor.white,fontWeight: FontWeight.bold)),
            ],),
            Con_widget.Space(h: 25, w: w),
            Expanded(child:
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                decoration: BoxDecoration(color: AppColor.white),
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Wellness Score')),
                ],
                rows: Wellness.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  int itemindex = index+1;
                  return DataRow(
                    cells: [
                      DataCell(Text(itemindex.toString())),
                      DataCell(Text(formatDate(item['Date'].toString()))),
                      DataCell(Text(item['DailyQ'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ))
          ]),
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
}
