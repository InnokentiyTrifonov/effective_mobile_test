abstract interface class SaveDestinationInterface {
  Future<void> saveCity(String key, String name);
  String? getSavedCity(String key);
  Future<void> removeCity(String key);
}
