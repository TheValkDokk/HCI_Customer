import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/models/cart.dart';
import 'package:hci_customer/screens/payment.dart';
import 'package:hci_customer/widgets/cart_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen();

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final key = GlobalKey<AnimatedListState>();
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
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          setState(() {});
        },
        child: Consumer(
          builder: (context, ref, child) {
            var list = ref.watch(cartListProvider);
            return list.isEmpty
                ? const Center(
                    child: Text("Your cart is Empty"),
                  )
                : buildCartList(context, list, ref);
          },
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  Column buildCartList(BuildContext context, List<Cart> list, WidgetRef ref) {
    double price = 0;
    ref.watch(cartListProvider).forEach((e) => price += e.price);
    var formatter = NumberFormat('#,###');
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
                  child: CartTile(i, refresh));
            },
            itemCount: list.length,
          ),
        ),
        list.isEmpty
            ? Container()
            : Expanded(
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
                            '${formatter.format(price).toString()},000',
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
                          onPressed: () async {
                            await Navigator.pushNamed(
                                context, PaymentScreen.routeName,
                                arguments: price);
                            refreshKey.currentState!.show();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
