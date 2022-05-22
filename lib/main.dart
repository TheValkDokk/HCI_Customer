import 'package:flutter/material.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home.dart';

void main() => runApp(ProviderScope(child: MyApp()));

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
      initialRoute: HomeScreen.routeName,
      title: 'Material App',
      // home: const PaymentScreen(),
    );
  }
}
