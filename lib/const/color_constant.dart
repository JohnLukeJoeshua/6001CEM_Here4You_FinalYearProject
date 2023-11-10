import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  static Color white  =  Color(0xffffffff);
  static Color black  =  Color(0xff000000);
  static Color black1 =  Color(0xb2000000);
  static Color grey   =  Color(0xffe8e6ea);
  static Color grey1  =  Color(0xff858585);
  static Color themColor  = Color(0xff1f93e8);
  static Color Backgroundthem  = Color(0xff37b9ff);
  static Color transparent= Colors.transparent;
}

class AppAsset {
  static const String defaultFont = 'Poppins-Regular';
  static const String one         = 'assets/Images/1.jpg';
  static const String Backgroud   = 'assets/Images/Backgroud.jpg';
  static const String person      = 'assets/Images/profile.webp';
  static const String archivment  = 'assets/Images/archivment.png';
  static const String Meditation  = 'assets/Images/Meditation.jpg';
  static const String Meditation1 = 'assets/Images/meditation1.jpg';
  static const String Meditation2 = 'assets/Images/Meditation2.png';
  static const String Meditation3 = 'assets/Images/meditetion3.jpg';
  static const String Meditation4 = 'assets/Images/meditetion4.png';
  static const String Stress      = 'assets/Images/stresh.png';
  static const String Depre       = 'assets/Images/Depression.png';
  static const String Nodata      = 'assets/Images/no.png';
  static const String Lock        = 'assets/Images/Lock.png';
  static const String Done        = 'assets/Images/Done.png';
  static const String Note        = 'assets/Images/Notes.png';

  static List MeditationImage     =
  [
    Meditation1,
    Meditation2,
    Meditation3,
    Meditation4,
    Stress,
    Depre
  ];
  static getRandomImage() {
    Random random = Random();
    return MeditationImage[random.nextInt(MeditationImage.length)];
  }
}
class AppIcon{
  static Icon addfav  =  Icon(Icons.star_border_purple500_sharp,color: AppColor.black,);
  static Icon fav     =  Icon(Icons.star,color:AppColor.white,);
  static Icon arrow_forward =  Icon(Icons.arrow_forward,color:AppColor.white,);
  static Icon Play     =  Icon(Icons.play_circle,color: AppColor.white,);
  static Icon Bookmark =  Icon(Icons.bookmark_add,color: AppColor.white,);
  static Icon help    =  Icon(Icons.help,color: AppColor.black,);
  static Icon  Back   =  Icon(Icons.arrow_back_outlined,color: AppColor.black,size: 30,);
  static Icon Edit    =  Icon(Icons.edit_note,color: AppColor.themColor,);
  static Icon time    =   Icon(Icons.timer_outlined,color: AppColor.black,);
  static Icon Delete  =   Icon(Icons.delete,color: AppColor.black,);
  static Icon Done    =   Icon(Icons.done,color: AppColor.black,);
  static Icon heart   =   Icon(Icons.favorite_outline,color: AppColor.themColor,);
  static Icon Addlike =   Icon(Icons.favorite_outline,color: AppColor.black,size: 32,);
  static Icon like    =   Icon(Icons.favorite,color: AppColor.black,size: 32,);
  static Icon Addnote =   Icon(Icons.note_add,color: AppColor.black,size: 32,);
  static Icon flash   =   Icon(Icons.flash_on,color: AppColor.themColor,);
  static const IconData local_fire_department_sharp = IconData(0xea8c, fontFamily: 'MaterialIcons');
}