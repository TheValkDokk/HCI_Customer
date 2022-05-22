import 'package:flutter/material.dart';
import 'package:hci_customer/screens/payment.dart';

import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        PaymentScreen.routeName: (context) => const PaymentScreen(),
      },
      title: 'Material App',
      home: const HomeScreen(),
      // home: const PaymentScreen(),
    );
  }
}
