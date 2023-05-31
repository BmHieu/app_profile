import 'package:connectivity/connectivity.dart';
import 'package:dailycanhan/blocs/db/db_cubit.dart';
import 'package:dailycanhan/data/local/storage.dart';
import 'package:dailycanhan/helpers/connectivity.dart';
import 'package:dailycanhan/helpers/utils.dart';
import 'package:dailycanhan/screens/home_screen_base.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  InternetConnectivity? _connectivity;

  @override
  void initState() {
    _setupFirstTimeLaunchApp();
    _checkAuth();
    context.read<DbCubit>().initLocalDb();
    super.initState();
  }

  @override
  void dispose() {
    _connectivity!.disposeStream();
    super.dispose();
  }

  _checkAuth() {
    // context.read<AuthCubit>().check();
  }

  _setupConnectivityStream() {
    _connectivity = InternetConnectivity.instance;
    _connectivity!.initialise();
    _connectivity!.myStream.listen((source) {
      if (source.keys.toList()[0] != ConnectivityResult.none) {
        context.read<DbCubit>().syncLocalData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DbCubit, DbState>(
      listener: (context, state) {
        if (state is InitDbSuccess) _setupConnectivityStream();
      },
      child: const HomeScreenBase(),
      // child: BlocBuilder<AuthCubit, AuthState>(
      //   builder: (context, state) {
      //     if (state is UserAuthenticated) {
      //       return HomeScreen();
      //     } else {
      //       return LoginScreen();
      //     }
      //   },
      // ),
    );
  }

  _setupFirstTimeLaunchApp() async {
    await _setCurrentLocal();
  }

  _setCurrentLocal() async {
    try {
      context.locale = (await storage.getLanguage()) == 'vi' ? const Locale('vi', 'VN') : const Locale('vi', 'VN');
    } catch (error) {
      utils.logError(content: "_setCurrentLocal() error $error");
      context.locale = const Locale('vi', 'VN'); // fallback
    }
  }
}
