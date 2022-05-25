import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart' as it;

import '../models/cart.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen();

  static const routeName = '/payment';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
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
    print("object");
    price = 0;
    for (var element in cartL) {
      price += element.price;
    }
    Size size = MediaQuery.of(context).size;
    var formatter = it.NumberFormat('###,###');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Checkout"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
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
                SizedBox(
                  height: size.height * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RichText(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RichText(
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
                                    Icons.delivery_dining,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: " ETA: 1 week",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Consumer(
                  builder: ((context, ref, child) {
                    var list = ref.watch(cartLProvider);
                    price = calcTotal(list);
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
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            leading: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Image.network(list[i].drug.imgUrl),
                            ),
                            title: Text(
                              list[i].drug.fullName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                  letterSpacing: 1, fontSize: 15),
                            ),
                            subtitle: Text(
                                '${list[i].price.toStringAsFixed(3)} - ${list[i].quantity} ${list[i].drug.unit}'),
                            trailing: IconButton(
                                onPressed: () {
                                  list.removeAt(i);
                                  if (list.isEmpty) {
                                    Navigator.pop(context, true);
                                  } else {
                                    setState(() {
                                      price = calcTotal(list);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                )),
                          ),
                        );
                      },
                      itemCount: list.length,
                    );
                  }),
                ),
                SizedBox(
                  height: size.height * 0.1,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
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
                child: Text(
                  "Confirm Order: ${formatter.format(price).toString()},000",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
