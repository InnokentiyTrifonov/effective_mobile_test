import 'package:effective_mobile_test/domain/save_destination_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDestinationService implements SaveDestinationInterface {
  final SharedPreferences storage;

  SaveDestinationService({required this.storage});

  @override
  Future<void> saveCity(String key, String name) async {
    await storage.setString(key, name);
  }

  @override
  String? getSavedCity(String key) {
    return storage.getString(key);
  }

  @override
  Future<void> removeCity(String key) async {
    await storage.remove(key);
  }
}
