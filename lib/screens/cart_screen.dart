import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hci_customer/models/cart.dart';
import 'package:hci_customer/widgets/cart_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  final ZoomDrawerController _drawerController;

  const CartScreen(this._drawerController);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Consumer(
        builder: (context, ref, child) {
          var list = ref.watch(cartListProvider);
          double price = 0;
          for (var element in list) {
            price += element.price;
          }
          print("rebuild");
          return list.isEmpty
              ? const Center(
                  child: Text("Your cart is Empty"),
                )
              : buildCartList(context, list, ref);
        },
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  Column buildCartList(BuildContext context, List<Cart> list, WidgetRef ref) {
    double price = 0;
    ref.watch(cartListProvider).forEach((e) => price += e.price);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemBuilder: (_, i) {
              return Slidable(
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            list.removeAt(i);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remove',
                      )
                    ],
                  ),
                  child: CartTile(i, widget._drawerController, refresh));
            },
            itemCount: list.length,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Total Price: ",
                      style: TextStyle(letterSpacing: 1, fontSize: 18),
                    ),
                    Text(
                      price.toString(),
                      style: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: const Text("Checkout"),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
