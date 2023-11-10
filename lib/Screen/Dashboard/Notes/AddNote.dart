import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  //final dbHelper = DatabaseHelper();
  DateTime Now=DateTime.now();
  String formattedDate="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Set_Data();
  }
  Set_Data()
  {
    formattedDate = DateFormat('dd-MM-yyyy').format(Now);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
             if(title.text.isEmpty && description.text.isEmpty)
               {
                 Con_widget.Tost(BuildContext: context, name: "Enter Title or Description");
               }else{
                // dbHelper.insertItemNote(title.text, description.text,formattedDate);
                Firestore.AddNote(title: title.text, Description: description.text, Date: formattedDate);
                // dbHelper.updateDataAchievements(5, {"Done" : 1});
                Firestore.findDocumentByFieldValue(collection: "Achievements", FieldName: "Achievements", fieldNamevalue: "Write your 1st Journal entry", Data: {"Done" : 1});
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Homescreen(Index: 3,);
                },));
             }
        },child: Icon(Icons.save)),
        body: SafeArea(
          child: Column(
            children: [
              Con_widget.Space(h: 25, w: 0),
              Row(
                children: [
                  Con_widget.Space(h: 0, w: 10),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },child: AppIcon.Back),
                  Con_widget.Space(h: 0, w: 25),
                  Text("Add Note",
                      style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20))
                ],
              ),
              Con_widget.Space(h: 25, w: 0),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(formatDate(formattedDate),style: TextStyle(fontSize: 16,color: AppColor.black,fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              TextFormField(
                controller: title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Expanded(
                child: TextFormField(
                  maxLines: 50,
                  controller: description,
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
formatDate(String inputDate) {
  // Parse the input date in the original format
  DateTime dateTime = DateFormat('dd-MM-yyyy').parse(inputDate);

  // Format the date in the desired format
  String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

  return formattedDate;
}