import 'package:flutter/material.dart';
import 'package:hci_customer/models/drugs.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/payment';

  @override
  Widget build(BuildContext context) {
    var drug = listDrug[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Checkout"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 10),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    WidgetSpan(
                      child: Text(
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        "    Delivery Location",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          textAlign: TextAlign.left,
                          " Cao Chanh Duc",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.phone,
                              size: 25,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: " 0123456789",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.home,
                            size: 25,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " 19 D16 Phuoc Binh Quan 9, TP.HCM",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
