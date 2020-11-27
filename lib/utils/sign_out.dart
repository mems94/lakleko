import 'package:shared_preferences/shared_preferences.dart';

signOut() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('value', null);
}