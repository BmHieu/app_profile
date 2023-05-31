import 'package:dailycanhan/config/config.dart';
import 'package:dailycanhan/helpers/theme/theme_provider.dart';
import 'package:dailycanhan/helpers/theme/themes.dart';
import 'package:dailycanhan/screen_router.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenRouter = ScreenRouter();
    final Themes theme = Provider.of<ThemeProvider>(context).getTheme(context);
    App.theme = theme;

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        backgroundColor: App.theme?.colors.background,
        primaryColor: theme.colors.primary500,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: theme.colors.primary500),
        bottomAppBarColor: Colors.white,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: theme.colors.white,
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: App.theme?.colors.background,
          elevation: .5,
        ),
        unselectedWidgetColor: theme.colors.primary500,
        // for checkbox
        fontFamily: 'Inter',
        dividerTheme: DividerThemeData(thickness: 1, color: theme.colors.neutral300),
      ),
      onGenerateRoute: screenRouter.generateRoute,
      onUnknownRoute: screenRouter.unknownRoute,
      initialRoute: '/',
    );
  }
}
