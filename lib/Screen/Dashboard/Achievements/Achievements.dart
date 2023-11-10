import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../Sharepref/Sharepref.dart';
import '../../../const/Con_Data.dart';
import '../../../const/Con_widget.dart';
import '../../../const/Constant_usermast.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';
import '../HomeScreen/WellnessHistory.dart';
import 'UpdatePFNscrore.dart';
import 'package:here4you/widget/lottie_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  double h = 0;
  double w = 0;
  //final dbHelper = DatabaseHelper();
  List Dailywellness = [];
  List Chart = [];
  List Achievements = [];
  double Average = 0;

  List<BarChartGroupData> Bardata = [];
  bool Wellnessis7 = false;
  String formattedAverage = "0.00";
  List<int> numbers = [];
  bool loading = false;
  int badges = 0;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("Achievements");

    super.initState();
    GetData();
  }

  void logPageView(String Achievements) {
    analytics.logEvent(name: Achievements);
  }

  GetData() async {
    Dailywellness = await Firestore.Get_Wellness();
    Achievements = await Firestore.Get_Achievment();
    print(Achievements);
    Chart = await Firestore.Get_Chart();
    print(Chart);
    Chart.sort((a, b) {
      final DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime dateA = format.parse(a["Date"]);
      DateTime dateB = format.parse(b["Date"]);
      return dateA.compareTo(dateB);
    });
    Con_Data.Time = await SharedPref.read_int(SrdPrefkey.Time) ?? 0;
    Chart.forEach((element) {
      BarChartGroupData barData = BarChartGroupData(
        x: element['id'], // You can set the x value as needed
        barRods: [
          BarChartRodData(
            color: AppColor.Backgroundthem, // Set the value from the input
            width: 20, // Set the width as needed
            toY: double.parse(element['DailyQ'].toString()), // Set the color as needed
          ),
        ],
        showingTooltipIndicators: [0], // Show tooltip for this bar
        // Other properties like barWidth, borderRadius, etc., can be customized as needed
      );
      Bardata.add(barData);
    });

    Achievements.forEach((element) {
      if(element['Done']==1)
        {
          badges++;
        }
    });
    loading = true;
   if(mounted)
     {
       setState(() {});
     }
  }

  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(10),
          child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Homescreen(
                            Index: 0,
                          );
                        },
                      ));
                    },
                    child: AppIcon.Back),
                Con_widget.Space(h: h / 40, w: w),
                Text(
                  "Hi, ${Constants_Usermast.Name}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250, // Set the desired width
                      height: 250, // Set the desired height
                      child: LottieWidget(
                        path: 'assets/Animation/43792-yoga-se-hi-hoga.json',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Emotional Health",
                      style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )
                  ],
                ),
                Con_widget.CommonButton(
                  Name: "Your Wellness Activity here",
                  color: AppColor.Backgroundthem,
                  textcolor: AppColor.black,
                  OnTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return UpdatePFNscrore();
                      },
                    ));
                  },
                ),
                Text(
                  "Statistics",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: h / 18,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue, // Set the background color to light blue
                          borderRadius: BorderRadius.circular(20), // Adjust border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.9),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.local_fire_department, // Change the icon to represent a streak
                              color: Colors.white, // Text color
                            ),
                            Text(
                              "${Dailywellness.length} Streak",
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: h / 18,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue, // Set the background color to light blue
                          borderRadius: BorderRadius.circular(20), // Adjust border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.9),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white, // Text color
                            ),
                            Text(
                              "${Con_Data.Time} Minutes",
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: h / 18,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,  // Set the background color to light blue
                          borderRadius: BorderRadius.circular(20), // Adjust border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.9),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.favorite, // Change the icon to a heart icon (as in the original code)
                              color: Colors.white,  // Text color
                            ),
                            Text(
                              "${formattedAverage}",  // Use the same dynamic value as in the original code
                              style: TextStyle(
                                color: Colors.white,  // Text color
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Average \nWellness",  // Use the same static text as in the original code
                              style: TextStyle(
                                color: Colors.white,  // Text color
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: h / 18,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,  // Set the background color to light blue
                          borderRadius: BorderRadius.circular(20),  // Adjust border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.9),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star,  // Change the icon to a flash icon (as in the original code)
                              color: Colors.white,  // Text color
                            ),
                            Text(
                              "$badges Badges earned",  // Use the same dynamic value as in the original code
                              style: TextStyle(
                                color: Colors.white,  // Text color
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                Con_widget.Space(h: 15, w: w),
                Text(
                  "Wellness Activity",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
                Con_widget.Space(h: 30, w: w),
                Container(
                  height: 300,
                  child: loading
                      ? Chart.isEmpty
                          ? Center(
                            child: Text(
                              "You do not have enough data for the chart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black),
                            ),
                          )
                          : BarChart(BarChartData(
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: getBottomTitles))
                                  ),
                              maxY: 5,
                              minY: 0,
                              barGroups: Bardata
                                  .map((data) =>
                                      BarChartGroupData(x: data.x, barRods: data.barRods))
                                  .toList()))
                      : Center(
                          child: CircularProgressIndicator(
                          color: AppColor.black,
                        )),
                ),
                Con_widget.Space(h: 15, w: w),
                Con_widget.CommonButton(
                  Name: "My Wellness History",
                  color: AppColor.Backgroundthem,
                  textcolor: AppColor.white,
                  OnTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WellnessHistory();
                      },
                    ));
                  },
                ),
                Con_widget.Space(h: 15, w: w),
                Text(
                  "Achievements",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
                Con_widget.Space(h: 15, w: w),
                Container(
                  height: h / 2,
                  child:loading ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColor.transparent,
                            // child: Achievements[index]['Done'] == 0 ? Image.asset(fit: BoxFit.f,AppAsset.Lock) : Image.asset(AppAsset.Done),
                            backgroundImage: Achievements.where((element) => element['Achievements']==Con_Data.Archivment[index]).first['Done'] == 0
                                ? AssetImage(AppAsset.Lock)
                                : AssetImage(AppAsset.Done),
                          ),
                          title: Text(
                            "${Con_Data.Archivment[index]}",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: Con_Data.Archivment.length) :  Center(child: CircularProgressIndicator(color: AppColor.black),),
                )
              ],
            ),
          )),
    ));
  }

  formatDate(String inputDate) {
    // Parse the input date in the original format
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(inputDate);

    // Format the date in the desired format
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }
  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
    Widget? text;
    if(value==Chart.firstWhere((element) => element['id']==value)['id'])
      {
        String Date = Chart.firstWhere((element) => element['id']==value)['Date'].toString();
        text = Text(DatetoWeekname(Date),
          style: style,
        );
      }else{
      text = Text("");
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }

  DatetoWeekname(String Date) {
    String pattern = 'dd-MM-yyyy';
    DateFormat format = DateFormat(pattern);
    DateTime dateTime1 = format.parse(Date);
    final weekdayName = DateFormat('EEEE').format(dateTime1);
    return weekdayName.toString().substring(0, 3);
  }
  GetAverage() {
    int sum = 0;
    for (int number in numbers) {
      sum += number;
    }
    Average = sum / numbers.length;
    formattedAverage = Average.toStringAsFixed(2);
    setState(() {});
  }
}
