import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hci_customer/models/user.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/home_drawer.dart';
import 'screens/login_sceen.dart';

final googleSignInProvider = StateProvider((_) => GoogleSignIn());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  static const routeName = '/main';

  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final db = FirebaseFirestore.instance;
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
        HomeDrawer.routeName: (context) => const HomeDrawer(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData) {
            sendUser();
            return const HomeDrawer();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }

  Future<void> sendUser() async {
    final u = FirebaseAuth.instance.currentUser!;
    final phone = u.phoneNumber ?? 0;
    final user = PharmacyUser(
        mail: u.email, name: u.displayName, phone: phone.toString(), addr: '');
    if (!checkExist(user)) {
      db.collection('users').doc(user.mail).set(user.toFirestore());
    }
  }

  bool checkExist(PharmacyUser u) {
    bool isExist = false;
    db.collection('users').get().then((value) {
      for (var e in value.docs) {
        if (e.data()['mail'] == u.mail) {
          isExist = true;
        }
      }
    });
    return isExist;
  }
}
