import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width <= 640;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1007 && MediaQuery.of(context).size.width > 640;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1007;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static Orientation? orientation;
  static double? defaultSize;
  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
    defaultSize = orientation == Orientation.landscape ? screenHeight! * 0.025 : screenWidth! * 0.025;
  }
}

num getRealHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight.toDouble();
}

num getRealWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth.toDouble();
}
