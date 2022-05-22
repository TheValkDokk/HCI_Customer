import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/widgets/cart_tile.dart';

import '../screens/cart_screen.dart';
import 'cart.dart';
import 'drugs.dart';

void showAddedMsg(BuildContext context, Drug drug, WidgetRef ref) {
  //print(drug.id);
  final list = ref.watch(cartListProvider);

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

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'To my Cart',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
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
