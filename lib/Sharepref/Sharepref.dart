import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/Con_Data.dart';
import '../const/Constant_usermast.dart';

class SrdPrefkey {
  static String  Email = "Email";
  static String  Name = "Name";
  static String  UserId = "UserId";
  static String  ChartId = "ChartId";
  static String  Password = "Password";
  static String Login = "Login";
  static String Time = "Time";
  static String Profileimage = "Image";
  static String Note = "Notes";
  static String NoteDate = "NotesDate";
}

class SharedPref {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == "null" ||
        prefs.getString(key) == "" ||
        prefs.getString(key) == "[]" ||
        prefs.getString(key) == null) {
      return "";
    }
    // print(key);
    return json.decode(prefs.getString(key) ?? '');
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static save_string(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, (value));
  }

  static read_string(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return (prefs.getString(key) ?? '');
  }

  static save_int(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static read_int(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(key) ?? 0);
  }

  static remove_key(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
  // static save_Contact(String key, List<Show_Contact> a) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String encode = Show_Contact.encode(a);
  //   prefs.setString(key, json.encode(encode));
  // }

  static savelist(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, (value));
  }

  static readlist(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> Value = prefs.getStringList(key) ?? [];
    if (Value.isEmpty) {
      return Value;
    }
    return Value;
  }
  static read_bool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static save_bool(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  static SyncUserData() async {
    Constants_Usermast.Login = await SharedPref.read_bool(SrdPrefkey.Login) ?? false;
    Constants_Usermast.Email = await SharedPref.read_string(SrdPrefkey.Email);
    Constants_Usermast.UserId = await SharedPref.read_string(SrdPrefkey.UserId);
    Constants_Usermast.Name = await SharedPref.read_string(SrdPrefkey.Name) ?? "";
    Constants_Usermast.Password = await SharedPref.read_string(SrdPrefkey.Password);
    Con_Data.Time = await SharedPref.read_int(SrdPrefkey.Time) ?? 0;

  }
  static SetDataSharepref({
    String? name,
    required String Uid,
    required String Email,
    required String Password,
    required bool Login
})
  async {
    await SharedPref.save_string(SrdPrefkey.Email,Email);
    await SharedPref.save_string(SrdPrefkey.UserId,Uid);
    await SharedPref.save_string(SrdPrefkey.Name,name ?? "");
    await SharedPref.save_string(SrdPrefkey.Password,Password);
    await SharedPref.save_bool(SrdPrefkey.Login,Login);
    SharedPref.SyncUserData();
  }

}
