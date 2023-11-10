import 'package:flutter/material.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  double h = 0;
  double w = 0;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          TextButton(onPressed: () {
           Navigator.pop(context);
          }, child: AppIcon.Back),
          Con_widget.Space(h: h/5, w: w),
          ListTile(title: Text("Terms and conditions",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.black)),trailing: Icon(Icons.arrow_drop_down_sharp)),
          ListTile(title: Text("Agreement",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.black)),trailing: Icon(Icons.arrow_drop_down_sharp)),
          Con_widget.Space(h: 30, w: 10),
          Con_widget.CommonButton(Name: "Help Center", color: AppColor.Backgroundthem, textcolor: AppColor.white, OnTap: () {

          },)
        ]),
      ),
    ));
  }
}
