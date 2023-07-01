import 'app_database.dart';

abstract class InstanceDatabase {
  Future<AppDatabase> getInstance();
}

class InstanceFloor extends InstanceDatabase {
  @override
  Future<AppDatabase> getInstance() async =>
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
