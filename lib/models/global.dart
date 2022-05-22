import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import 'cart.dart';
import 'drugs.dart';

void showAddedMsg(BuildContext context, Drug drug) {
  //print(drug.id);
  if (cartList.isEmpty) {
    cartList.add(Cart(drug: drug, quantity: 1, price: drug.price));
  } else if (cartList.isNotEmpty) {
    for (var e in cartList) {
      if (e.drug.id == drug.id) {
        print('yes');
        e.quantity++;
        e.price = e.quantity * e.drug.price;
        return;
      }
    }
    cartList.add(Cart(drug: drug, quantity: 1, price: drug.price));
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
