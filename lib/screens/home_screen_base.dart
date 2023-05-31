import 'package:dailycanhan/config/config.dart';
import 'package:dailycanhan/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreenBase extends StatefulWidget {
  const HomeScreenBase({Key? key}) : super(key: key);

  @override
  _HomeScreenBaseState createState() => _HomeScreenBaseState();
}

class _HomeScreenBaseState extends State<HomeScreenBase> {
  bool _isVisible = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomTab(),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            Container(),
            Container(),
            Container(),
            Container(),
            // HomeScreen(),
            // StoresScreen(),
            // ProductsScreen(),
            // NewsScreen(),
            // ProfileScreen()
          ],
        ),
      ),
    );
  }

  Widget _bottomTab() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (int index) => setState(() => _currentIndex = index),
      selectedFontSize: 5,
      selectedItemColor: App.theme!.colors.primary500,
      unselectedItemColor: App.theme!.colors.neutral300,
      unselectedFontSize: 5,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.home_2,
            color: _currentIndex == 0 ? App.theme!.colors.primary500 : App.theme!.colors.neutral300,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.menu,
            color: _currentIndex == 1 ? App.theme!.colors.primary500 : App.theme!.colors.neutral300,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.bag,
            color: _currentIndex == 2 ? App.theme!.colors.primary500 : App.theme!.colors.neutral300,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.user,
            color: _currentIndex == 3 ? App.theme!.colors.primary500 : App.theme!.colors.neutral300,
          ),
          label: '',
        ),
      ],
    );
  }
}
