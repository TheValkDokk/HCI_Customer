import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/widgets/cart_tile.dart';

import '../screens/cart_screen.dart';
import 'cart.dart';
import 'drugs.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void addorInc(Drug drug, WidgetRef ref) {
  final list = ref.watch(cartListProvider);
  snackbarKey.currentState?.hideCurrentSnackBar();
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
        .read(cartListProvider)
        .add(Cart(drug: drug, quantity: 1, price: drug.price));
  }
}

void showAddedMsg(BuildContext context, Drug drug, WidgetRef ref, var drawer) {
  //print(drug.id);

  addorInc(drug, ref);

  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'To my Cart',
        onPressed: () {
          snackbarKey.currentState?.hideCurrentSnackBar();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CartScreen(drawer)));
        },
        textColor: Colors.cyanAccent,
      ),
      content: Row(
        children: const [
          Icon(
            Icons.shopping_bag_rounded,
            color: Colors.white,
          ),
          SizedBox(width: 15),
          Text("Item added to cart"),
        ],
      ),
      backgroundColor: Colors.green,
    ),
  );
}
