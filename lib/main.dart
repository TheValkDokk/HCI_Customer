import 'package:flutter/material.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/global.dart';
import 'screens/home.dart';
import 'screens/home_drawer.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: HomeDrawer(),
    );
  }
}
