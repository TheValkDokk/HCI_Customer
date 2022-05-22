import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../models/cart.dart';
import '../screens/info.dart';

final cartListProvider = StateProvider<List<Cart>>((ref) => cartList);

class CartTile extends StatefulWidget {
  const CartTile(this.index, this._drawerController, this.notifyParent);

  final int index;
  final ZoomDrawerController _drawerController;
  final Function() notifyParent;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  var countController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      width: size.width,
      color: Colors.white,
      child: Consumer(builder: (context, ref, child) {
        var cart = ref.watch(cartListProvider).elementAt(widget.index);
        countController.text = cart.quantity.toString();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            InfoScreen(cart.drug, widget._drawerController)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Hero(
                      tag: cart.drug.id,
                      child: Image.network(
                        height: size.height * 0.1,
                        width: size.width * 0.4,
                        cart.drug.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      cart.drug.fullName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 16, letterSpacing: 1.0),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.green,
                        ),
                      ),
                      TextSpan(
                        text: " ${cart.drug.rating}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            cart.quantity++;
                            if (cart.quantity == 0) {
                              ref.watch(cartListProvider).remove(cart);
                            } else {
                              cart.price = cart.quantity * cart.drug.price;
                            }
                            widget.notifyParent();
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle_outlined,
                          color: Colors.green,
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: TextField(
                        onSubmitted: (value) => setState(() {
                          cart.quantity = int.parse(value);
                          if (cart.quantity <= 0) {
                            ref.watch(cartListProvider).remove(cart);
                          } else {
                            cart.price = cart.quantity * cart.drug.price;
                          }
                          widget.notifyParent();
                        }),
                        textAlign: TextAlign.center,
                        controller: countController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              cart.quantity--;
                              if (cart.quantity == 0) {
                                ref.watch(cartListProvider).remove(cart);
                              } else {
                                cart.price = cart.quantity * cart.drug.price;
                              }
                              widget.notifyParent();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.remove_circle_outlined,
                          color: Colors.green,
                        )),
                  ],
                ),
                Text(
                  'Total: ${cart.price.toStringAsFixed(3)}',
                  style: const TextStyle(fontSize: 15, letterSpacing: 1),
                )
              ],
            ),
            const Divider()
          ],
        );
      }),
    );
  }
}
