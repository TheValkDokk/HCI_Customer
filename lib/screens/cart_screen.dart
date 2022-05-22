import 'package:flutter/material.dart';
import 'package:hci_customer/models/cart.dart';
import 'package:hci_customer/widgets/cart_tile.dart';

class CartScreen extends StatelessWidget {
  var list = cartList;
  @override
  Widget build(BuildContext context) {
    print(list.length);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: list.isEmpty
          ? const Center(
              child: Text("Your cart is Empty"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return CartTile(cartList[i]);
                },
                itemCount: list.length,
              ),
            ),
    );
  }
}
