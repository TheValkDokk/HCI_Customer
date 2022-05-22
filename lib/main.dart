import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci_customer/screens/cart_screen.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/global.dart';
import 'screens/about.dart';
import 'screens/drawer.dart';
import 'screens/home.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _drawerController = ZoomDrawerController();

  var currentItem = MenuItems.home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      routes: {
        PaymentScreen.routeName: (context) => const PaymentScreen(),
      },
      initialRoute: HomeScreen.routeName,
      title: 'Material App',
      home: ZoomDrawer(
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
