// import 'package:flutter/material.dart';
// import '../../../const/Con_Data.dart';
// import '../../../const/Con_widget.dart';
// import '../../../const/color_constant.dart';
//
// class AllLenguage extends StatefulWidget {
//   const AllLenguage({super.key});
//
//   @override
//   State<AllLenguage> createState() => _AllLenguageState();
// }
//
// class _AllLenguageState extends State<AllLenguage> {
//   bool isSelected = false;
//   double height = 0;
//   double width = 0;
//   int selected =0;
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//          body: Container(
//            height: height,
//            width: width,
//            color: AppColor.Backgroundthem,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//              TextButton(
//                  onPressed: () {
//                    Navigator.pop(context);
//                    // dbHelper.insertItem(formattedDate, 6);
//                  },
//                  child: AppIcon.Back),
//              Con_widget.Space(h: 15, w: width),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Text(
//                    "Pause for peace",
//                    style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 18),
//                  )
//                ],
//              ),
//              Con_widget.Space(h: 5, w: width),
//              Container(
//                height: height*0.6,
//                padding: EdgeInsets.only(left: 25,right: 25,top: 35,bottom: 10),
//                child: GridView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2,
//                      crossAxisSpacing: 15,
//                      mainAxisSpacing: 15,
//                      childAspectRatio: 3.5
//                  ),
//                  itemCount: Con_Data.Language.length,
//                  itemBuilder: (context, index) {
//
//                    return GestureDetector(
//                      onTap: () {
//                        selected = index;
//                        setState(() {
//                        });
//                      },
//                      child: Container(
//                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                        decoration: BoxDecoration(
//                          boxShadow: [
//                            BoxShadow()
//                          ],
//                          border: Border.all(color: AppColor.grey),
//                          borderRadius: BorderRadius.circular(15),
//                          color: selected==index ? AppColor.black : AppColor.white,
//                        ),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Text(
//                              Con_Data.Language[index],
//                              style: TextStyle(
//                                color: selected==index ?  AppColor.white : AppColor.black,
//                                fontSize: height * 0.018,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    );
//                  },
//                ),
//              ),
//            ]),
//          ),
//       ),
//     );
//   }
// }
