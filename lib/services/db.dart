import 'package:dailycanhan/helpers/exceptions.dart';
import 'package:dailycanhan/helpers/utils.dart';

class AppHiveDb {
  AppHiveDb._();
  static AppHiveDb instance = AppHiveDb._();
  // Box<User>? userBox;
  // Box<Product>? productBox;

  bool initialized = false;

  Future init() async {
    try {
      if (initialized) {
        return;
      }
      initialized = true;
      // var _directory = await getApplicationDocumentsDirectory();
      // Hive..init(_directory.path)
      // ..registerAdapter(UserAdapter())
      // ..registerAdapter(ProductAdapter());

      // userBox = await Hive.openBox<User>('userBox');
      // productBox = await Hive.openBox<Product>('productBox');
    } catch (e) {
      utils.logError(content: e.toString());
      throw SetupDbFailedException();
    }
  }

  clearData() {
    // userBox!.clear();
    // productBox!.clear();
  }
}
