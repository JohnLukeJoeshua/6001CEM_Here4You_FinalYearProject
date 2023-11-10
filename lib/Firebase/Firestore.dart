import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:here4you/Sharepref/Sharepref.dart';
import '../DatabaseHelper/DatabaseHelper.dart';
import '../const/Constant_usermast.dart';

class Firestore{
  static String Wellness = "Wellness_history";
  static String Achievements = "Achievements";
  static String Chart = "Chart";
  static String Favorite = "Favorite";
  static String Notes = "Notes";
  // static //final dbHelper = DatabaseHelper();
  static Future<void> deleteAllChart() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(Constants_Usermast.UserId)
        .collection(Chart)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
  static Future<void> deleteAllNote() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(Constants_Usermast.UserId)
        .collection(Notes)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
  static Future<void> deleteAllWellness() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(Constants_Usermast.UserId)
        .collection(Wellness)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }static Future<void> deleteAllAchievements() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(Constants_Usermast.UserId)
        .collection(Achievements)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }static Future<void> deleteAllFav() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(Constants_Usermast.UserId)
        .collection(Favorite)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
  static AddWellNess_history({required String Date,required int Daily}){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(Constants_Usermast.UserId).collection(Wellness).doc(users.doc().id).set({
        "Date": Date,
        "DailyQ":Daily
      }).then((value) => (value) {
      });
  }
  static AddChart({required String Date,required int Daily,required int id}) async {
    // int id = await SharedPref.read_int(SrdPrefkey.ChartId) ?? 0;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(Constants_Usermast.UserId).collection(Chart).doc(users.doc().id).set({
      "Date": Date,
      "DailyQ":Daily,
      "id" : id+1
    }).then((value) => (value) {});
    // await SharedPref.save_int(SrdPrefkey.ChartId, id++);
  }

  static AddAchievements({required String Achievments}){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(Constants_Usermast.UserId).collection(Achievements).doc(users.doc().id).set({
        "Achievements":Achievments,
        "Done": 0
      }).then((value) => (value) {
      });
  }
  static AddNote({required String title,required String Description,required String Date}){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(Constants_Usermast.UserId).collection(Notes).doc(users.doc().id).set({
        'title': title,
        'Description' : Description,
        "Date" : Date
      }).then((value) => (value) {
    });
  }
  static AddFav({required String cource,required String Imagename,required String mainCource}){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(Constants_Usermast.UserId).collection(Favorite).doc(users.doc().id).set({
        'CourceName': cource,
        'Cource' : mainCource,
        'ImageName': "$Imagename",
      }).then((value) => (value) {
      });
  }

  static Future<List> Get_Wellness({String? Uid}) async {
    List Data = await fetchDataFromCollection(name: Wellness,Uid: Uid ?? Constants_Usermast.UserId);
    return Data;
  }

  static Future<List> Get_Chart({String? Uid}) async {
   List Data = await fetchDataFromCollection(name: Chart,Uid: Uid ?? Constants_Usermast.UserId);
   // Data.forEach((element) {
   //   dbHelper.insertItemchart(element['Date'].toString(), element['DailyQ']);
   // });
    return Data;
  }static Future<List> Get_Fav({String? Uid}) async {
   List Data = await fetchDataFromCollection(name: Favorite,Uid: Uid ?? Constants_Usermast.UserId);
   // Data.forEach((element) {
   //   dbHelper.insertItemFavFirebase(element['CourceName'].toString(),element['imagefile'],element['Cource']);
   // });
    return Data;
  }
  static Future<List> Get_Achievment({String? Uid}) async {
   List Data = await fetchDataFromCollection(name: Achievements,Uid: Uid ?? Constants_Usermast.UserId);
   // Data.forEach((element) {
   //   dbHelper.insertItemAchievementsFirebase(element['Achievements'].toString(), element['Done']);
   // });
    return Data;
  }
  static Future<List> Get_Note({String? Uid}) async {
   List Data = await fetchDataFromCollection(name: Notes,Uid: Uid ?? Constants_Usermast.UserId);
   // Data.forEach((element) {
   //   dbHelper.insertItemNote(element['title'].toString(), element['Description'],element['Date']);
   // });
    return Data;
  }
 static Future<List<Map<String, dynamic>>> fetchDataFromCollection({required String name,required String Uid}) async {
   try {
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
     final QuerySnapshot querySnapshot = await _firestore.collection('users').doc(Uid).collection(name).get();
     final List<Map<String, dynamic>> data = [];

     for (var doc in querySnapshot.docs) {
       data.add(doc.data() as Map<String, dynamic>);
     }
     return data;
   } catch (e) {
     print('Error fetching data: $e');
     return [];
   }
 }
 static  Future<void> findDocumentByFieldValue({required String collection,required String FieldName,required String fieldNamevalue,required Map<String,dynamic> Data}) async {// Replace with the value you're looking for
    final CollectionReference _myCollection = FirebaseFirestore.instance.collection('users').doc(Constants_Usermast.UserId).collection(collection);
    try {
      QuerySnapshot querySnapshot = await _myCollection.where(FieldName, isEqualTo: fieldNamevalue).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the matching documents
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String documentId = documentSnapshot.id;
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
          // Process the data as needed
          await _myCollection.doc(documentId).update(Data);
        }
      } else {
        print("No documents found with the specified field value.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  static  Future<void> DeleteMethod({required String collection,required String FieldName,required String fieldNamevalue}) async {// Replace with the value you're looking for
    final CollectionReference _myCollection = FirebaseFirestore.instance.collection('users').doc(Constants_Usermast.UserId).collection(collection);
    try {
      QuerySnapshot querySnapshot = await _myCollection.where(FieldName, isEqualTo: fieldNamevalue).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the matching documents
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String documentId = documentSnapshot.id;
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
          // Process the data as needed
          await _myCollection.doc(documentId).delete();
        }
      } else {
        print("No documents found with the specified field value.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}