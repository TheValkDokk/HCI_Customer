import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hci_customer/screens/Home/home.dart';
import 'package:hci_customer/screens/about/nearby.dart';
import 'package:hci_customer/screens/payment/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/Home/components/home_drawer.dart';
import 'screens/login/login_sceen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static const routeName = '/main';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
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
        MyApp.routeName: (context) => const MyApp(),
        NearbyStoreScreen.routeName: (context) => const NearbyStoreScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      home: const MainAppBuilder(),
    );
  }
}

class MainAppBuilder extends ConsumerStatefulWidget {
  const MainAppBuilder();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppBuilderState();
}

class _MainAppBuilderState extends ConsumerState<MainAppBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snap.hasData) {
          return const HomeDrawer();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
