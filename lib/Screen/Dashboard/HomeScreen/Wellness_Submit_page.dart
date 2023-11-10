import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../DatabaseHelper/DatabaseHelper.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import 'WellnessHistory.dart';

class Wellness_Sabmit_page extends StatefulWidget {
  @override
  State<Wellness_Sabmit_page> createState() => _Wellness_Sabmit_pageState();
}

class _Wellness_Sabmit_pageState extends State<Wellness_Sabmit_page> {
  double h = 0;
  double w = 0;
  //final dbHelper = DatabaseHelper();
  DateTime Now = DateTime.now();
  String formattedDate = "";
  List Dailywellness = [];
  List Chart = [];
  bool loading =false;
  List<BarChartGroupData> Bardata = [];
  int Score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetDateAnndQuition();
  }

  @override
  SetDateAnndQuition() async {
    formattedDate = DateFormat('dd-MM-yyyy').format(Now);
    Dailywellness = await Firestore.Get_Wellness();
    Chart = await Firestore.Get_Chart();
    Chart.sort((a, b) {
      final DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime dateA = format.parse(a["Date"]);
      DateTime dateB = format.parse(b["Date"]);
      return dateA.compareTo(dateB);
    });
    Dailywellness.forEach((element) {
      if (element['Date'] == formattedDate) {
        Score = element['DailyQ'];
      }
    });
    Chart.forEach((element) {
      BarChartGroupData barData = BarChartGroupData(
        x: element['id'], // You can set the x value as needed
        barRods: [
          BarChartRodData(
            color: AppColor.white, // Set the value from the input
            width: 20, // Set the width as needed
            toY: double.parse(element['DailyQ'].toString()), // Set the color as needed
          ),
        ],
        showingTooltipIndicators: [0], // Show tooltip for this bar
        // Other properties like barWidth, borderRadius, etc., can be customized as needed
      );
      Bardata.add(barData);
    });
    Future.delayed(Duration(seconds: 1)).then((value) {
      loading=true;
      setState(() {
      });
    },);
    setState(() {});
  }
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              color: AppColor.Backgroundthem,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // dbHelper.insertItem(formattedDate, 6);
                    },
                    child:AppIcon.Back),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Wellness Check-In",
                      style: TextStyle(color: AppColor.white, fontSize: 30),
                    )
                  ],
                ),
                Con_widget.Space(h: 15, w: w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your wellness score today is.....",
                      style: TextStyle(color: AppColor.white),
                    )
                  ],
                ),
                Con_widget.Space(h: 15, w: w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        maxRadius: h / 15,
                        backgroundColor: AppColor.black,
                        child: Text(
                          Score.toString(),
                          style: TextStyle(
                              color: AppColor.white, fontSize: h * 0.05),
                        ))
                  ],
                ),
                Con_widget.Space(h: 15, w: w),
                 Container(
                  height: 300,
                  child:  loading ?
                  Chart.isEmpty ? Center(child: Text(
                    "You do not have enough data for the chart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),): BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(show: true,
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: getBottomTitles))
                      // leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      // bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      maxY: 5,
                      minY: 0,
                      barGroups: Bardata.map((data) => BarChartGroupData(x: data.x, barRods:data.barRods))
                          .toList()))
                      :Center(child: CircularProgressIndicator(color: AppColor.white,)),
                ),
                Con_widget.Space(h: 25, w: w),
                // Text("Recommended ",
                //     style: TextStyle(
                //         color: AppColor.black,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 18)),
                // Container(
                //   height: h / 8,
                //   margin: EdgeInsets.all(10),
                //   child: GridView.builder(
                //     physics: BouncingScrollPhysics(),
                //     scrollDirection: Axis.horizontal,
                //     padding: EdgeInsets.only(right: 10, left: 10),
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 1, // Number of columns
                //         crossAxisSpacing: 10,
                //         mainAxisSpacing: 10,
                //         childAspectRatio: 0.7),
                //     itemCount: Con_Data.Peacefulness_courses.length,
                //     // Total number of items in the grid
                //     itemBuilder: (BuildContext context, int index) {
                //       return InkWell(
                //         highlightColor: AppColor.transparent,
                //         onTap: () {
                //
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: AppColor.black,
                //             borderRadius: BorderRadius.all(Radius.circular(10)),
                //             image: DecorationImage(
                //                 fit: BoxFit.cover,
                //                 image: AssetImage(
                //                     AppAsset.MeditationImage[index])),
                //           ),
                //           child: Column(children: [
                //             Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   Padding(
                //                     padding: EdgeInsets.all(5),
                //                     child: InkWell(
                //                         onTap: () {
                //                           if (Fav.where((element) => element['CourceName'] == Con_Data.Peacefulness_courses[index]).isEmpty) {
                //                             dbHelper.insertItemFav(
                //                                 Con_Data.Peacefulness_courses[
                //                                     index],
                //                                 AppAsset.MeditationImage[index]
                //                                     .toString());
                //                             GetFav();
                //                           } else {
                //                             dbHelper.deleteDataFav(Fav.firstWhere((element) => element['CourceName'] == Con_Data.Peacefulness_courses[index])['id']);
                //                             GetFav();
                //                           }
                //                           GetFav();
                //                         },
                //                         child: Fav.where((element) => element['CourceName'] == Con_Data.Peacefulness_courses[index]).isEmpty
                //                             ? AppIcon.Addlike
                //                             : AppIcon.like),
                //                   )
                //                 ]),
                //             Spacer(),
                //             Container(
                //               alignment: Alignment.center,
                //               height: 20,
                //               width: w,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.only(
                //                       bottomLeft: Radius.circular(10),
                //                       bottomRight: Radius.circular(10)),
                //                   color: AppColor.white.withOpacity(0.6)),
                //               child: Text(
                //                 "${Con_Data.Peacefulness_courses[index]}",
                //                 style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold,
                //                     color: AppColor.black),
                //               ),
                //             ),
                //           ]),
                //         ),
                //       );
                //       ;
                //     },
                //   ),
                // ),
                Con_widget.CommonButton(
                  textcolor: AppColor.black,
                  color: AppColor.white,
                  Name: "My Wellness History",
                  OnTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return WellnessHistory();
                      },
                    ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
    Widget? text;
    if(value==Chart.firstWhere((element) => element['id']==value)['id'])
    {
      String Date = Chart.firstWhere((element) => element['id']==value)['Date'].toString();
      print(Date);
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

}
