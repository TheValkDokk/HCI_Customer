import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci_customer/screens/drawer.dart';

import 'about.dart';
import 'home.dart';

final UserProvider = StateProvider((_) => FirebaseAuth.instance.currentUser);

class HomeDrawer extends ConsumerStatefulWidget {
  const HomeDrawer();

  static const routeName = '/home_drawer';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends ConsumerState<HomeDrawer> {
  final _drawerController = ZoomDrawerController();
  var currentItem = MenuItems.home;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(UserProvider.state).state = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade400,
      child: ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        controller: _drawerController,
        borderRadius: 24.0,
        showShadow: true,
        mainScreenTapClose: true,
        androidCloseOnBackTap: true,
        drawerShadowsBackgroundColor: Colors.green,
        openCurve: Curves.fastOutSlowIn,
        mainScreen: getScreen(),
        menuScreen: DrawerScreen(
          currentItem: currentItem,
          onSelectedItem: (item) => changeScreen(item),
        ),
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
