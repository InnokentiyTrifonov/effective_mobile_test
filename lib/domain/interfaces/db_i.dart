abstract interface class DbI {
  Future<void> saveCurrentCity(String name);
  Future<void> saveDesiredCity(String name);

  String? getCurrentCity();
  String? getDesiredCity();

  Future<void> removeCurrentCity();
  Future<void> removeDesiredCity();
}
