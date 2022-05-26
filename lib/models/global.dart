import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../screens/cart_screen.dart';
import 'cart.dart';
import 'drugs.dart';
import 'order.dart';

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
        .state
        .add(Cart(drug: drug, quantity: 1, price: drug.price));
  }
}

void sendOrder(Order order) {
  db
      .collection('orders')
      .add(order.toMap())
      .then((_) => print('added'))
      .catchError((e) => print(e));
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
