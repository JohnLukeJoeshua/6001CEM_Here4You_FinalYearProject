import 'package:flutter/material.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';

class Click_play extends StatefulWidget {
  const Click_play({super.key});

  @override
  State<Click_play> createState() => _Click_playState();
}

class _Click_playState extends State<Click_play> {
  double h = 0;
  double w = 0;
  bool Submit =false;
  bool DonePage =false;
  TextEditingController Ans =TextEditingController();
  @override
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
                    child: AppIcon.Back),
                Con_widget.Space(h: 15, w: w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "10 Steps for Peacefulness",
                      style: TextStyle(color: AppColor.black),
                    )
                  ],
                ),
                Con_widget.Space(h: 5, w: w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "The Power of Intention",
                      style: TextStyle(color: AppColor.white, fontSize: 30),
                    )
                  ],
                ),
                Con_widget.Space(h: h/6, w: w),
              Submit ? DonePage ? Container(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Try two carry thise intontion \nforward with you \nthroughout your day",style: TextStyle(color: AppColor.white, fontSize: 20),),
                    Con_widget.Space(h: h/20, w: w),
                    Text("Don't worry,we'll remind you!",style: TextStyle(color: AppColor.white, fontSize: 20),),
                    Con_widget.Space(h: h/20, w: w),
                    Con_widget.CommonButton(Name: "Done", color: AppColor.white, textcolor: AppColor.Backgroundthem, OnTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                           return Homescreen(Index: 1,);
                         },));
                    },)
              ]),) :
              Container(child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.cloud_done_rounded,size: h/6),
                  ],),
                Con_widget.Space(h: 10, w: w),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text(
                    "       You took a step \ntowards peace today !",
                    style: TextStyle(color: AppColor.white, fontSize: 30),
                  )
                ],)
              ]),) :Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("How can I be at peace today?",
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                    ],
                  ),
                  Con_widget.Space(h: 10, w: w),
                  Container(
                    height: h / 6,
                    width: w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)),
                    child:  TextField(
                      maxLines: null,
                      controller: Ans,
                      expands: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Example : I do not hold any kind of anger today',
                      ),
                    ),
                  ),
                  Con_widget.Space(h: h/20, w: w),
                  Con_widget.CommonButton(
                    textcolor: AppColor.black,
                    color: AppColor.white,
                    Name: "Submit",
                    OnTap: () {
                      Submit=true;
                      Donecalling();
                      setState(() {
                      });
                    },
                  )
                ]),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Donecalling()
  {
    Future.delayed(Duration(seconds: 5)).then((value) {
      DonePage=true;
      setState(() {
      });
    },);
  }
}
