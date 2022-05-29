import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hci_customer/models/user.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'provider/general_provider.dart';
import 'screens/home_drawer.dart';
import 'screens/login_sceen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  static const routeName = '/main';

  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
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
    var user = PharmacyUser(
        mail: u.email,
        name: u.displayName,
        phone: phone.toString(),
        addr: 'user home');
    checkExist(user);
  }

  Future<void> checkExist(PharmacyUser u) async {
    final userCollection = db.collection('users');
    await userCollection.get().then((value) {
      for (var e in value.docs) {
        if (e.data()['mail'] == u.mail) {
          userCollection.doc(u.mail).get().then((doc) {
            ref.read(pharmacyUserProvider.notifier).state =
                PharmacyUser.fromFirestore(doc);
          });
          return;
        }
      }
      db.collection('users').doc(u.mail).set(u.toFirestore());
    });
  }
}
