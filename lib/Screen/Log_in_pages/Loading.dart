import 'package:flutter/material.dart';
import '../../const/Con_widget.dart';
import '../../const/color_constant.dart';
import 'Relaxation.dart';



class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double h = 0;
  double w=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to another page after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Relaxation()),
      );
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
             decoration: BoxDecoration(image: DecorationImage(
                 fit: BoxFit.fill,
               image: AssetImage('assets/Images/Background2.jpg'))),
           child: Column(
               children:[
                 Padding(
                   padding: EdgeInsets.only(top: h/4,bottom: 10),
                   child: Text("Welcome",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColor.black),),
                 ),
                 Text("This app will help to manage your",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.black),),
                 Text("mental wellness",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.black),),
                 Con_widget.Space(h: 50, w: 10)
           ]),
         ),
      ),
    );
  }
}
