import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hci_customer/widgets/cart_tile.dart';

class CartScreen extends ConsumerWidget {
  final ZoomDrawerController _drawerController;

  const CartScreen(this._drawerController);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list = ref.watch(cartListProvider);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          : ListView.builder(
              itemBuilder: (_, i) {
                return CartTile(list[i], _drawerController);
              },
              itemCount: list.length,
            ),
    );
  }
}
