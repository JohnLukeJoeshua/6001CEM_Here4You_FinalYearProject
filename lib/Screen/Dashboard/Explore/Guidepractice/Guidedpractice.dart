import 'package:flutter/material.dart';
import '../../../../const/Con_Data.dart';
import '../../../../const/color_constant.dart';
import '../../HomeScreen/HomeScreen.dart';
import 'Breathing_exercise.dart';
import 'Meditate_Exercise.dart';

class Guidedpractice extends StatefulWidget {
  const Guidedpractice({super.key});

  @override
  State<Guidedpractice> createState() => _GuidedpracticeState();
}

class _GuidedpracticeState extends State<Guidedpractice> {
  double h = 0;
  double w =0;
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
                  Expanded(child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 10,left: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8
                    ),
                    itemCount:Con_Data.Guided_practice.length, // Total number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        highlightColor: AppColor.transparent,
                        onTap: () {
                           if(Con_Data.Guided_practice[index]=="Breathin Exercise"){
                             Navigator.push(context, MaterialPageRoute(builder: (context) {
                               return Brathing_exercise();
                             },));
                           }else if(Con_Data.Guided_practice[index]=="Meditate Exercise")
                             {
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return Meditate_Exercise();
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
                            Spacer(),
                            Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  color: AppColor.white.withOpacity(0.6)),
                              child: Text("${Con_Data.Guided_practice[index]}",
                                style: TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.black),),
                            ),
                            // Text("${Con_Data.Guided_practice[index]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black),)
                          ]),
                        ),
                      );
                    },
                  ))
                ]),
          ),
        ),
      ),
    );;
  }
}
