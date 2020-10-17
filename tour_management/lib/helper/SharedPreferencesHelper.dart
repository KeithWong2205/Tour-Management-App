import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_management/models/users_repo/user_model.dart';


class AppDataHelper {

  static final AppDataHelper _instance = AppDataHelper._internal();

  var _sharedPreferences;

  /// MARK: Constructor
  factory AppDataHelper() {
    return _instance;
  }

  AppDataHelper._internal();

  /// MARK: Getter functions
  Future<SharedPreferences> getSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences;
  }

  /// MARK: Clear functions (Static)
  static Future<void> clearUser() {
    return setUser(null);
  }

  /// MARK: Getter functions (Static)
  static Future<UserModel> getUser() async {
    return _instance.getSharedPreferences().then((preferences) {
      String jsonString = preferences.getString('user_data');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return UserModel.fromData(jsonMap);
    });
  }

  /// MARK: Setter functions
  static Future<void> setUser(UserModel user) async {
    return _instance.getSharedPreferences().then((preferences) => {
      preferences.setString('user_data', user == null ? '' : json.encode(user.toJson()))
    });
  }
}