import 'dart:async';

import 'package:dailycanhan/data/local/storage.dart';
import 'package:dailycanhan/generated/codegen_loader.g.dart';
import 'package:dailycanhan/helpers/theme/theme_provider.dart';
import 'package:dailycanhan/helpers/utils.dart';
import 'package:dailycanhan/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase cubit) {
    super.onCreate(cubit);
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    utils.errorToast(error.toString());
  }
}

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initialize();
  runZoned(() async {
    Bloc.observer = SimpleBlocObserver();
    await storage.init();

    runApp(EasyLocalization(
        supportedLocales: [const Locale('en', 'US'), const Locale('vi', 'VN')],
        path: 'locales',
        fallbackLocale: const Locale('vi', 'VN'),
        assetLoader: const CodegenLoader(),
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Routes(),
          ),
        )));
  });
}

Future initialize() async {
  await Future.delayed(const Duration(seconds: 1));
}
