import 'package:flutter/material.dart';
import 'package:here4you/Firebase/Firestore.dart';
import 'package:intl/intl.dart';
import '../../../const/Con_widget.dart';
import '../../../const/color_constant.dart';
import '../HomeScreen/HomeScreen.dart';

class Noteshow extends StatefulWidget {
  Map Note;
  Noteshow(this.Note);

  @override
  State<Noteshow> createState() => _NoteshowState();
}

class _NoteshowState extends State<Noteshow> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  //final dbHelper = DatabaseHelper();
  DateTime Now=DateTime.now();
  String Titile = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Titile = widget.Note['title'];
    title.text=widget.Note['title'];
    description.text=widget.Note['Description'];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Column(
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
                Text("Note",
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20)),
                Spacer(),
                InkWell(
                    onTap: () {
                      // dbHelper.deleteDataNote(widget.Note['id']);
                      Firestore.DeleteMethod(collection: "Notes", FieldName: "title", fieldNamevalue: Titile,);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Homescreen(Index: 3,);
                      },));
                    },
                    child: AppIcon.Delete),
                Con_widget.Space(h: 0, w: 15),
                InkWell(
                    onTap: () {
                      // dbHelper.updateDataNote(widget.Note['id'], {"title" : title.text,"Description" : description.text});
                      Firestore.findDocumentByFieldValue(collection: "Notes", FieldName: "title", fieldNamevalue: Titile, Data:{"title" : title.text,"Description" : description.text});
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Homescreen(Index: 3,);
                      },));
                    },
                    child: AppIcon.Done),
                Con_widget.Space(h: 0, w: 15),
              ],
            ),
            Con_widget.Space(h: 25, w: 0),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(formatDate(widget.Note['Date']),style: TextStyle(fontSize: 16,color: AppColor.black,fontWeight: FontWeight.w400)),
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
    );
  }
  formatDate(String inputDate) {
    // Parse the input date in the original format
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(inputDate);

    // Format the date in the desired format
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

    return formattedDate;
  }
}
