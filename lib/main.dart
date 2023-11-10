import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/Dashboard/HomeScreen/HomeScreen.dart';
import 'Screen/Log_in_pages/Sign_in.dart';
import 'Sharepref/Sharepref.dart';
import 'const/Constant_usermast.dart';
import 'const/color_constant.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final dbHelper = DatabaseHelper();
  // await dbHelper.initDatabase();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Constants_Usermast.Login = prefs.getBool(SrdPrefkey.Login) ?? false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  Splash(),
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}


class Splash extends StatefulWidget {
  const Splash({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Time();
  }
  Time()
  {
    Future.delayed(
        Duration(seconds: 3)).then((value) {
      if(Constants_Usermast.Login)
        {
          SharedPref.SyncUserData();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Homescreen();
        },));
        }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Sign_in();
        },));
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Image(
            image: AssetImage('assets/Images/Here4You.png'), // Use AssetImage to load the image
            fit: BoxFit.scaleDown, // You can choose the BoxFit that suits your needs
          ),
          // Remove the decoration property as it's no longer needed
          // Remove the Column and Text widgets
        ),
      ),
    );
  }
}



