import 'package:dailycanhan/helpers/theme/themes.dart';

enum Environment { Local, Dev, Prod }

class App {
  // This contains global variables. We should avoid using this in case you have special reason.
  static Themes? theme;
}

class ConfigApp {
  static Map<String, dynamic>? _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.Local:
        _config = _ConfigMap.localConfig;
        break;
      case Environment.Dev:
        _config = _ConfigMap.devConfig;
        break;
      case Environment.Prod:
        _config = _ConfigMap.prodConfig;
        break;
    }
  }

  static bool isProd() => _config == _ConfigMap.prodConfig;

  static get baseURL {
    return _config![_ConfigMap.BASE_URL];
  }
}

class _ConfigMap {
  static const BASE_URL = "BASE_URL";

  static Map<String, dynamic> localConfig = {
    BASE_URL: "https://totoday-api.mltechsoft.com",
  };

  static Map<String, dynamic> devConfig = {
    BASE_URL: "https://totoday-api.mltechsoft.com",
  };

  static Map<String, dynamic> prodConfig = {
    BASE_URL: "https://totoday-api.mltechsoft.com",
  };
}
