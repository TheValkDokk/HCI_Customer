import 'package:flutter/material.dart';

import '../models/global.dart';
import '../screens/payment_complete.dart';

class BtnConfirmOrder extends StatelessWidget {
  const BtnConfirmOrder(this.price);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentCompleteScreen(),
                ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: Text(
            "Confirm Order: ${formatter.format(price).toString()},000",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
