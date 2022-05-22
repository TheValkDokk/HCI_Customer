import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci_customer/screens/drawer.dart';

import 'about.dart';
import 'home.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final _drawerController = ZoomDrawerController();
  var currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      controller: _drawerController,
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.green,
      openCurve: Curves.fastOutSlowIn,
      mainScreen: getScreen(),
      menuScreen: DrawerScreen(
        currentItem: currentItem,
        onSelectedItem: (item) => changeScreen(item),
      ),
    );
  }

  void changeScreen(var item) {
    setState(() {
      currentItem = item;
      Timer(const Duration(milliseconds: 10), () {
        _drawerController.close!();
      });
    });
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return HomeScreen(_drawerController, (item) => changeScreen(item));
      case MenuItems.about:
        return const AboutScreen();
      default:
        return HomeScreen(_drawerController, (item) => changeScreen(item));
    }
  }
}
