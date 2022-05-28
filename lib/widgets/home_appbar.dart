import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../screens/cart_screen.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar(this.drawerController);

  final ZoomDrawerController drawerController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => drawerController.toggle!(),
        icon: const Icon(Icons.menu_rounded),
      ),
      title: const Text("Pharmacy"),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
