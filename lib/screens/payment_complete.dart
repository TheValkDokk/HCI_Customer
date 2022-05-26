import 'package:flutter/material.dart';
import 'package:hci_customer/main.dart';

class PaymentCompleteScreen extends StatelessWidget {
  const PaymentCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        children: [
          Image.network(
              'https://i.pinimg.com/736x/7b/dd/1b/7bdd1bc7db7fd48025d4e39a0e2f0fd8.jpg'),
          ElevatedButton(
              onPressed: () {
                navKey.currentState!.popUntil((route) => route.isFirst);
              },
              child: const Text('Back To Home'))
        ],
      )),
    );
  }
}
