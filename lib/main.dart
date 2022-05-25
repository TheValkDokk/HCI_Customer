import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_drawer.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  late final ZoomDrawerController drawerController;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const HomeDrawer(),
    );
  }
}
