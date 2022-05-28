import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hci_customer/widgets/remove_all_dialog.dart';
import 'package:string_validator/string_validator.dart';

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

  final u = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    nameCtl.text = u.displayName.toString();
    if (u.phoneNumber.toString() == 'null') {
      phoneCtl.text = '';
    } else {
      phoneCtl.text = u.phoneNumber.toString();
    }
    addressCtl.text = '';
    super.initState();
  }

  @override
  void dispose() {
    nameCtl.dispose();
    addressCtl.dispose();
    phoneCtl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (nameCtl.text.isNotEmpty &&
        phoneCtl.text.isNotEmpty &&
        addressCtl.text.isNotEmpty) {
      isFilled = true;
    }
    super.didChangeDependencies();
  }

  bool isPhoneNumber(String input) {
    return isNumeric(input) && isLength(input, 9, 10);
  }

  String? get errorTextPhoneInput {
    if (!isPhoneNumber(phoneCtl.text)) {
      return 'Invaild Phone Number';
    }
    return null;
  }

  String? get errorTextNameInput {
    if (nameCtl.text.isEmpty) {
      return 'Empty Name';
    }
    return null;
  }

  String? get errorTextAddrInput {
    if (addressCtl.text.isEmpty) {
      return 'Empty Address';
    }
    return null;
  }

  bool isFilled = false;
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
                  child: Column(
                    children: [
                      inputCusData(size, Icons.person, nameCtl, 'Full Name',
                          TextInputType.name, false),
                      inputCusData(size, Icons.phone, phoneCtl, 'Phone Number',
                          TextInputType.phone, true),
                      inputCusData(size, Icons.location_city, addressCtl,
                          'Address', TextInputType.streetAddress, false),
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
                SizedBox(height: size.height * 0.1)
              ],
            ),
          ),
          BtnConfirmOrder(
              isFilled, price, nameCtl.text, phoneCtl.text, addressCtl.text),
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
                  ref.read(cartLProvider.notifier).remove(list[i]);
                  if (ref.watch(cartLProvider).isEmpty) {
                    Navigator.pop(context, true);
                  }
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Remove',
              )
            ],
          ),
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
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierLabel: "Barrier",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) {
                  return const RemoveDialog();
                },
                transitionBuilder: (_, anim, __, child) {
                  Tween<Offset> tween;
                  if (anim.status == AnimationStatus.reverse) {
                    tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
                  } else {
                    tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
                  }
                  return SlideTransition(
                    position: tween.animate(anim),
                    child: FadeTransition(
                      opacity: anim,
                      child: child,
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete_rounded,
            ))
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

  Row inputCusData(Size size, IconData icon, var ctl, String hint,
      TextInputType kbType, bool isPhone) {
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
          child: isPhone
              ? TextField(
                  controller: ctl,
                  onChanged: (v) {
                    if (v.isEmpty) {
                      setState(() {
                        isFilled = false;
                      });
                    }
                  },
                  keyboardType: kbType,
                  decoration: InputDecoration(
                    labelText: hint,
                    errorText: errorTextPhoneInput,
                  ),
                )
              : TextField(
                  onChanged: (v) {
                    if (v.isEmpty) {
                      setState(() {
                        isFilled = false;
                      });
                    }
                  },
                  controller: ctl,
                  keyboardType: kbType,
                  decoration: InputDecoration(
                    labelText: hint,
                    errorText: ctl == nameCtl
                        ? errorTextNameInput
                        : errorTextAddrInput,
                  ),
                ),
        ),
      ],
    );
  }
}
