import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Firebase/AuthMethod.dart';
import '../../../Sharepref/Sharepref.dart';
import '../../../const/Con_widget.dart';
import '../../../const/Constant_usermast.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Edit_profile extends StatefulWidget {
  const Edit_profile({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Edit_profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  TextEditingController Email = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController Old = TextEditingController();
  TextEditingController New = TextEditingController();

  double h = 0;
  double w = 0;
  bool ChangePass = false;
  String Imagepath = "";
  final ImagePicker _picker = ImagePicker();

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

 @override
  void initState() {
    // TODO: implement initState

    // Log a custom event for tracking pages
    logPageView("Edit_profile");

   super.initState();
    Getdata();
  }

  void logPageView(String Edit_profile) {
    analytics.logEvent(name: Edit_profile);
  }


  Getdata() async {
    Email.text = Constants_Usermast.Email;
    pass.text = Constants_Usermast.Password;
    Name.text = Constants_Usermast.Name;
    Imagepath = await SharedPref.read_string(SrdPrefkey.Profileimage) ?? "";
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return WillPopScope(child: SafeArea(
        child: Scaffold(
          body: Container(
            height: h,
            width: w,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Homescreen(Index: 4,);
                      },));
                    },
                    child: AppIcon.Back),
                Con_widget.Space(h: h / 8, w: w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: h * 0.2,
                      width: w * 0.3,
                      child: Stack(children: [
                        Container(
                          alignment: Alignment.center,
                          height: h * 0.15,
                          decoration: Imagepath.isNotEmpty
                              ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(base64Decode(Imagepath))))
                              : BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AppAsset.person))),
                        ),
                        Positioned(
                          top: h * 0.11,
                          left: w * 0.2,
                          child: InkWell(
                            highlightColor: AppColor.transparent,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return bottomshit();
                                },
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColor.white,
                              child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.themColor,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
                Con_widget.textfield(
                    controller: Name,
                    hintText: "",
                    Readonly: true
                ),
                Con_widget.textfield(
                    controller: Email,
                    hintText: "",
                    Readonly: true),
                Con_widget.textfield(
                    controller: pass,
                    hintText: "",
                    Readonly: true,
                    obscureText: true),
                Constants_Usermast.Password.isNotEmpty ? ListTile(
                  onTap: () {
                    setState(() {
                      ChangePass = !ChangePass;
                    });
                  },
                  title: Text("Change Password & Name",
                      style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  trailing: Icon(
                    Icons.password,
                    color: AppColor.black,
                  ),
                ) : Container(),
                ChangePass ? Con_widget.textfield(
                    controller: Old,
                    hintText: "Old Password",
                    obscureText: true
                ) : Container(),
                ChangePass ? Con_widget.textfield(
                    controller: New,
                    hintText: "New Password",
                    obscureText: true) : Container(),
                ChangePass ? Con_widget.textfield(
                    controller: Name,
                    hintText: "Name",
                ) : Container(),
                Con_widget.Space(h: 15, w: w),
                ChangePass ? Con_widget.CommonButton(Name: "Submit", color: AppColor.themColor, textcolor: AppColor.white, OnTap: () async {
                  ChangePass=false;
                  if(New.text.isEmpty || Old.text.isEmpty && Name.text.isEmpty)
                    {
                      if(await AuthMethod.changeName(name: Name.text)){
                        Con_widget.Tost(BuildContext:context, name: "Name Change Succecfully");
                      }
                    }else if(Old.text.trim().isEmpty)
                  {
                    Con_widget.Tost(BuildContext:context, name: "Enter Old Password");
                  }else if(New.text.trim().isEmpty){
                    Con_widget.Tost(BuildContext:context, name: "Enter Password");
                  }else if (Name.text.isEmpty){
                    Con_widget.Tost(BuildContext:context, name: "Enter Name");
                  }else if(Old.text==pass.text)
                  {
                    if(await AuthMethod.change_password(email: Constants_Usermast.Email, old: Old.text, pass: New.text))
                      {
                        if(await AuthMethod.changeName(name: Name.text))
                          {
                            Con_widget.Tost(BuildContext:context, name: "Password & Name Change Succecfully");
                          }else{
                          Con_widget.Tost(BuildContext:context, name: "Please Sign in then try it");
                        }
                      }else{
                      Con_widget.Tost(BuildContext:context, name: "Please Sign in then try it");
                    }
                  }else{
                    Con_widget.Tost(BuildContext:context, name: "Old Password not match");
                  }
                },): Container()
              ]),
            ),
          ),
        )), onWillPop: () {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
           return Homescreen(Index: 4,);
         },));
          return Future(() => true);
        },);
  }

  Widget bottomshit() {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        Text(
          "Choose Profile image",
          style: TextStyle(fontSize: h * 0.02),
        ),
        Row(
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  Navigator.pop(context);
                  takeimage(ImageSource.camera);
                },
                icon: Icon(Icons.camera)),
            Text("Camera"),
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  takeimage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.image)),
            Text("Gallery"),
          ],
        )
      ]),
    );
  }

  takeimage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final imageBytes = await image.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        Imagepath = base64Image;
        await SharedPref.save_string(SrdPrefkey.Profileimage, base64Image);
        setState(() {});
      } else {
        print('No image selected.');
      }
    setState(()  {
    });
  }
}
