import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/models/user.dart';
import 'package:intl/intl.dart';

import 'general_provider.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/prescription/presciption_screen.dart';
import '../models/cart.dart';
import '../models/drugs.dart';
import '../models/order.dart';

var formatter = NumberFormat('###,###');
final db = FirebaseFirestore.instance;

void addorInc(Drug drug, WidgetRef ref, BuildContext ctx) {
  final list = ref.watch(cartLProvider);
  ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  if (list.isEmpty) {
    list.add(Cart(drug: drug, quantity: 1, price: drug.price));
  } else if (list.isNotEmpty) {
    for (var e in list) {
      if (e.drug.id == drug.id) {
        e.quantity++;
        e.price = e.quantity * e.drug.price;
        return;
      }
    }
    ref
        .read(cartLProvider.notifier)
        .add(Cart(drug: drug, quantity: 1, price: drug.price));
  }
}

void sendOrder(Order order) {
  db.collection('orders').add(order.toMap());
}

void updateUser(PharmacyUser u) {
  db.collection('users').doc(u.mail).update({'addr': u.addr, 'phone': u.phone});
}

void showAddedMsg(BuildContext context, Drug drug, WidgetRef ref) {
  addorInc(drug, ref, context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'To my Cart',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        },
        textColor: Colors.cyanAccent,
      ),
      content: SafeArea(
        child: Row(
          children: const [
            Icon(
              Icons.shopping_bag_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 15),
            Text("Item added to cart"),
          ],
        ),
      ),
      backgroundColor: Colors.green,
    ),
  );
}

void wipeData(WidgetRef ref) {
  ref.invalidate(cartLProvider);
  ref.invalidate(googleSignInProvider);
  ref.invalidate(UserProvider);
  ref.invalidate(ScreenProvider);
  ref.invalidate(pharmacyUserProvider);
  ref.invalidate(ImgPath);
}

saveUser() async {
  String addr = '';
  String phone = '';
  String role = 'USER';
  final db = FirebaseFirestore.instance;
  final fUser = FirebaseAuth.instance.currentUser!;
  try {
    await db
        .collection('users')
        .where('mail', isEqualTo: fUser.email)
        .get()
        .then((value) {
      addr = value.docs.first.data()['addr'];
      phone = value.docs.first.data()['phone'];
      role = value.docs.first.data()['role'];
    });
  } catch (e) {}
  PharmacyUser user = PharmacyUser(
      mail: fUser.email,
      name: fUser.displayName,
      imgUrl: fUser.photoURL,
      role: role == 'USER' ? 'USER' : role,
      phone: phone == '' ? '' : phone,
      addr: addr == '' ? '' : addr);
  FirebaseFirestore.instance
      .collection('users')
      .doc(user.mail)
      .set(user.toMap());
}
