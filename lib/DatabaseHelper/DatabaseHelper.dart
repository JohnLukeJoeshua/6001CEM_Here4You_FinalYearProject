//
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static Database? _database;
//   final String tableName = 'DailyData';
//   final String Favorites = 'Favorite';
//   final String Achievements = 'Achievements';
//   final String Notes = 'Notes';
//   final String Chart = 'Chart';
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     // If _database is null, initialize it
//     _database = await initDatabase();
//     // _database = await initdatedatabase();
//     return _database!;
//   }
//   Future<Database> initDatabase() async {
//     String path = join(await getDatabasesPath(), 'my_database.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int version) async {
//         // Create your tables here
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS $tableName (
//             id INTEGER PRIMARY KEY,
//             Date TEXT,
//             DailyQ INTEGER
//              )
//         ''');
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS $Chart (
//             id INTEGER PRIMARY KEY,
//             Date TEXT,
//             DailyQ INTEGER
//              )
//         ''');
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS $Favorites (
//             id INTEGER PRIMARY KEY,
//             CourceName TEXT,
//             Cource TEXT,
//             ImageName TEXT
//              )
//         ''');
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS $Achievements (
//             id INTEGER PRIMARY KEY,
//             Achievements TEXT,
//             Done INTEGER
//              )
//         ''');
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS $Notes (
//             id INTEGER PRIMARY KEY,
//             title TEXT,
//             Description TEXT,
//             Date TEXT
//              )
//         ''');
//       },
//     );
//   }
//
//
//   Future<void> insertItem(String Date, int DailyQ) async {
//     final db = await database;
//     await db.insert(
//       tableName,
//       {
//         'Date': Date,
//         'DailyQ': DailyQ,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   Future<void> insertItemchart(String Date, int DailyQ) async {
//     final db = await database;
//     await db.insert(
//       Chart,
//       {
//         'Date': Date,
//         'DailyQ': DailyQ,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   Future<void> insertItemFav(String cource,String Imagename,String mainCource) async {
//     final db = await database;
//     print(cource);
//     print(Imagename);
//     await db.insert(
//       Favorites,
//       {
//         'CourceName': cource,
//         'Cource' : mainCource,
//         'ImageName': "$Imagename",
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   Future<void> insertItemFavFirebase(String cource,String Image,String mainCource) async {
//     final db = await database;
//     await db.insert(
//       Favorites,
//       {
//         'CourceName': cource,
//         'Cource' : mainCource,
//         'ImageName': "$Image",
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   Future<void> insertItemAchievements(String Achievement) async {
//     final db = await database;
//     await db.insert(
//       Achievements,
//       {
//         'Achievements': Achievement,
//         "Done" : 0
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   Future<void> insertItemAchievementsFirebase(String Achievement,int Done) async {
//     final db = await database;
//     await db.insert(
//       Achievements,
//       {
//         'Achievements': Achievement,
//         "Done" : Done
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   Future<void> insertItemNote(String title,String Description,String Date) async {
//     final db = await database;
//     await db.insert(
//       Notes,
//       {
//         'title': title,
//         'Description' : Description,
//         "Date" : Date
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//
//
//   Future<List<Map<String, dynamic>>> getAllItems() async {
//     final db = await database;
//     return await db.query(tableName);
//   }
//   Future<List<Map<String, dynamic>>> getAllItemschart() async {
//     final db = await database;
//     return await db.query(Chart);
//   }
//   Future<List<Map<String, dynamic>>> getAllItemsFav() async {
//     final db = await database;
//     return await db.query(Favorites);
//   }
//   Future<List<Map<String, dynamic>>> getAllItemsAchievements() async {
//     final db = await database;
//     return await db.query(Achievements);
//   }
//   Future<List<Map<String, dynamic>>> getAllItemsNote() async {
//     final db = await database;
//     return await db.query(Notes);
//   }
//
//
//
//   Future<void> updateData(int id, Map<String, dynamic> data) async {
//     final db = await database;
//     await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
//   }
//   Future<void> updateDataChart(int id, Map<String, dynamic> data) async {
//     final db = await database;
//     await db.update(Chart, data, where: 'id = ?', whereArgs: [id]);
//   }
//   Future<void> updateDataFav(int id, Map<String, dynamic> data) async {
//     final db = await database;
//     await db.update(Favorites, data, where: 'id = ?', whereArgs: [id]);
//   }
//   Future<void> updateDataAchievements(int id, Map<String, dynamic> data) async {
//     final db = await database;
//     await db.update(Achievements, data, where: 'id = ?', whereArgs: [id]);
//   }
//   Future<void> updateDataNote(int id, Map<String, dynamic> data) async {
//     final db = await database;
//     await db.update(Notes, data, where: 'id = ?', whereArgs: [id]);
//   }
//
//
//
//   Future<void> deleteData(int id) async {
//     final db = await database;
//     await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
//     // return result.isNotEmpty ? result.first : null;
//   }
//   Future<void> deleteDatachart(int id) async {
//     final db = await database;
//     await db.delete(Chart, where: 'id = ?', whereArgs: [id]);
//     // return result.isNotEmpty ? result.first : null;
//   }
//   Future<void> deleteDataFav(int id) async {
//     final db = await database;
//     await db.delete(Favorites, where: 'id = ?', whereArgs: [id]);
//     // return result.isNotEmpty ? result.first : null;
//   }
//   Future<void> deleteDataAchievments(int id) async {
//     final db = await database;
//     await db.delete(Achievements, where: 'id = ?', whereArgs: [id]);
//     // return result.isNotEmpty ? result.first : null;
//   }
//   Future<void> deleteDataNote(int id) async {
//     final db = await database;
//     await db.delete(Notes, where: 'id = ?', whereArgs: [id]);
//     // return result.isNotEmpty ? result.first : null;
//   }
//   DeleteAllData() async {
//     final db = await database;
//     db.delete(Favorites);
//     db.delete(tableName);
//     db.delete(Achievements);
//     db.delete(Notes);
//     db.delete(Chart);
//   }
//   ChartDelete() async {
//     final db = await database;
//     db.delete(Chart);
//   }
// }