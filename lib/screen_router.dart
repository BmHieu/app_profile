import 'package:dailycanhan/blocs/db/db_cubit.dart';
import 'package:dailycanhan/generated/locale_keys.g.dart';
import 'package:dailycanhan/root.dart';
import 'package:dailycanhan/services/api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenArgument {
  static const USER = "user";
  static const PRODUCT = 'product';
}

class ScreenRouter {
  static const ROOT = '/';
  static const HOME = 'home';
  static const LOGIN = 'login';
  static const REGISTER = 'register';

  API api = API();
  void getCurrentScreen() {}
  var userRepo, productRepo;

  ScreenRouter() {
    // userRepo = UserRepo(api);
    // productRepo = ProductRepo(api);
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    var route = buildPageRoute(settings);
    Map? arguments = (settings.arguments ?? {}) as Map;
    switch (settings.name) {
      case ROOT:
        return route(const Root());
      case LOGIN:
      // return route(LoginScreen());
      case REGISTER:
      // return route(RegisterScreen());
      default:
        return unknownRoute(settings);
    }
  }

  Function buildPageRoute(RouteSettings settings) {
    var blocProviders = [
      // BlocProvider(create: (context) {
      //   var authCubit = AuthCubit(userRepo);
      //   authCubit.check();

      //   api.addErrorInterceptor((Exception error) {
      //     try {
      //       if (error is APIUnauthorizedException) {
      //         authCubit.unauthenticate(context);
      //       }
      //     } on APIUnauthorizedException catch (e) {
      //       print(e);
      //     } catch (e) {
      //       print(e);
      //     }
      //   });

      //   return authCubit;
      // }),
      BlocProvider(create: (context) => DbCubit()),
      // BlocProvider(create: (context) => ProductCubit(productRepo)),
      // BlocProvider(create: (context) => EditUserCubit(userRepo, geographyRepo)),
    ];

    return (Widget builder) => MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: blocProviders, child: builder),
          settings: settings,
        );
  }

  Route<dynamic> unknownRoute(RouteSettings settings) {
    var unknownRouteText = "No such screen for ${settings.name}";

    return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(unknownRouteText),
          const Padding(padding: EdgeInsets.all(10.0)),
          ElevatedButton(
            child: Text(LocaleKeys.common_back.tr()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
