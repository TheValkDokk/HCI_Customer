import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hci_customer/models/cart.dart';
import 'package:hci_customer/models/order.dart';
import 'package:hci_customer/models/user.dart';
import 'package:hci_customer/screens/home_drawer.dart';

import '../models/global.dart';
import '../screens/payment_complete.dart';

class BtnConfirmOrder extends ConsumerWidget {
  const BtnConfirmOrder(
      this.isEnable, this.price, this.name, this.phone, this.addr);

  final bool isEnable;
  final double price;
  final String name;
  final String phone;
  final String addr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: isEnable
              ? () {
                  var list = ref.watch(cartLProvider);
                  final u = ref.watch(UserProvider) as User;
                  Order order = Order(
                      user: PharmacyUser(
                          mail: u.email, name: name, phone: phone, addr: addr),
                      listCart: list,
                      price: price,
                      status: 'NewOrder');
                  sendOrder(order);
                  ref.read(cartLProvider.notifier).wipe();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentCompleteScreen(),
                    ),
                  );
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                isEnable ? Colors.green : Colors.red.shade400),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: Text(
            isEnable
                ? "Confirm Order: ${formatter.format(price).toString()},000"
                : 'Please Fill your Delivery Info',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
