import 'package:effective_mobile_test/interfaces/db_i.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Db implements DbI {
  final SharedPreferences storage;

  Db({required this.storage});

  @override
  String? getCurrentCity() => storage.getString(dotenv.env['current_city']!);

  @override
  String? getDesiredCity() => storage.getString(dotenv.env['desired_city']!);

  @override
  Future<void> removeCurrentCity() => storage.remove(dotenv.env['current_city']!);

  @override
  Future<void> removeDesiredCity() => storage.remove(dotenv.env['desired_city']!);

  @override
  Future<void> saveCurrentCity(String name) => storage.setString(dotenv.env['current_city']!, name);

  @override
  Future<void> saveDesiredCity(String name) => storage.setString(dotenv.env['desired_city']!, name);
}
