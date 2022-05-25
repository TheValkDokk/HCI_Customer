import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/cart.dart';
import '../widgets/btnConfirmOrder.dart';
import '../widgets/payment_tile.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen();

  static const routeName = '/payment';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  var addressCtl = TextEditingController();
  var nameCtl = TextEditingController();
  var phoneCtl = TextEditingController();

  bool isEditable = false;
  double price = 0;
  double calcTotal(List<Cart> list) {
    price = 0;
    for (var element in list) {
      price += element.price;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    var cartL = ref.watch(cartLProvider);
    price = 0;
    for (var element in cartL) {
      price += element.price;
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _deliveryLocation(),
                const Divider(),
                SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.2,
                  child: Column(
                    children: [
                      inputCusData(size, Icons.person, nameCtl,
                          'Input Your Full Name', TextInputType.name),
                      inputCusData(size, Icons.phone, phoneCtl,
                          'Input Your Full Name', TextInputType.phone),
                      inputCusData(size, Icons.location_city, addressCtl,
                          'Input Your Full Name', TextInputType.streetAddress),
                      etaTime(size, '1 weeks'),
                    ],
                  ),
                ),
                const Divider(),
                Consumer(
                  builder: ((context, ref, child) {
                    var list = ref.watch(cartLProvider);
                    price = calcTotal(list);
                    return _listviewPayment(list, context);
                  }),
                ),
                SizedBox(
                  height: size.height * 0.1,
                )
              ],
            ),
          ),
          BtnConfirmOrder(price),
        ],
      ),
    );
  }

  ListView _listviewPayment(List<Cart> list, BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
          // child: paymentTile(context, list, i),
          child: PaymentTile(i),
        );
      },
      itemCount: list.length,
    );
  }

  Padding _deliveryLocation() {
    return Padding(
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
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      centerTitle: true,
      title: const Text("Checkout"),
      leading: BackButton(
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
            onPressed: () => setState(() {
                  isEditable = !isEditable;
                }),
            icon: Icon(isEditable ? Icons.edit : Icons.edit_outlined))
      ],
    );
  }

  Row etaTime(Size size, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(
          Icons.delivery_dining,
          size: 25,
          color: Colors.green,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SizedBox(
            width: size.width * 0.7,
            child: Text(
              "ETA: $time",
              style: const TextStyle(letterSpacing: 1, fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }

  Row inputCusData(
      Size size, IconData icon, var ctl, String hint, TextInputType kbType) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.green,
        ),
        const Spacer(),
        SizedBox(
          width: size.width * 0.7,
          child: TextField(
            controller: ctl,
            keyboardType: kbType,
            decoration: InputDecoration(hintText: hint),
            enabled: isEditable,
          ),
        ),
      ],
    );
  }
}
