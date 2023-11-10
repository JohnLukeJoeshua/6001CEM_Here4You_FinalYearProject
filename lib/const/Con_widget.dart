import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Sharepref/Sharepref.dart';
import 'Con_Data.dart';
import 'color_constant.dart';

class Con_widget{

  static Space({required double h,required double w})
  {
    return SizedBox(height: h,width: w);
  }
  static Widget textfield(
      {
        required TextEditingController controller,
        required String hintText,
        ValueChanged<String>? OnChange,
        Icon? prefixIcon,
        IconButton? suffixIcon,
        bool? Readonly,
        TextInputType? keyboardType,
        bool? obscureText
      }
      ){
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: TextField(
        onChanged: OnChange,
        cursorColor: AppColor.black1,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType ?? null,
        controller: controller,
        readOnly: Readonly ?? false,
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? null,
          suffixIcon: suffixIcon??null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:AppColor.black1)),
          hintText: '$hintText',
          labelStyle: TextStyle(color: AppColor.black1),
          labelText: '$hintText',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
  static Widget Next({
    required String Name,
    double? h,
    double? W,
    required VoidCallback OnTap
  })
  {
    return Container(
      height: h ?? 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        highlightColor: AppColor.transparent,
        onTap: OnTap,
        child: Container(
          decoration: BoxDecoration(color: AppColor.themColor,borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text("$Name",style: TextStyle(color: AppColor.white),)),
        ),
      ),
    );
  }
  static Widget Home_page_Button({
    required String Name,
    double? h,
    double? W,
    required VoidCallback OnTap
  })
  {
    return Container(
      height: h ?? 60,
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      child: InkWell(
        highlightColor: AppColor.transparent,
        onTap: OnTap,
        child: Container(
          decoration: BoxDecoration(color: AppColor.black,borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Con_widget.Space(h: 0, w: 10),
            Text("$Name",style: TextStyle(color: AppColor.white),),
            AppIcon.arrow_forward,
                Con_widget.Space(h: 0, w: 2)
          ]),
        ),
      ),
    );
  }
  static Widget CommonButton({
    required String Name,
    double? h,
    double? W,
    required Color color,
    required Color textcolor,
    required VoidCallback OnTap
  })
  {
    return Container(
      height: h ?? 60,
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      child: InkWell(
        highlightColor: AppColor.transparent,
        onTap: OnTap,
        child: Container(
          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Con_widget.Space(h: 0, w: 10),
            Text("$Name",style: TextStyle(color:textcolor,fontSize: 16,fontWeight: FontWeight.bold),),
          ]),
        ),
      ),
    );
  }
  static Future Tost({
    required BuildContext,
    required String name
  })
  {
    return Fluttertoast.showToast(
        msg: "$name",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static SetTime()
  {
    Timer.periodic(Duration(minutes: 1), (timer) async {
      Con_Data.Time = await SharedPref.read_int(SrdPrefkey.Time) ?? 0;
      Con_Data.Time =   Con_Data.Time+1;
      await SharedPref.save_int(SrdPrefkey.Time,Con_Data.Time);
    });
  }
}