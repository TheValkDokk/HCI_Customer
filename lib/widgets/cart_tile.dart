import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart.dart';
import '../screens/info.dart';
import 'flip_stock.dart';

class CartTile extends ConsumerStatefulWidget {
  const CartTile(this.index);

  final int index;

  @override
  ConsumerState<CartTile> createState() => _CartTileState();
}

class _CartTileState extends ConsumerState<CartTile> {
  var countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cart = ref.watch(cartLProvider).elementAt(widget.index);

    countController.text =
        ref.watch(cartLProvider).elementAt(widget.index).quantity.toString();
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.2,
        width: size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => InfoScreen(cart.drug)));
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
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: FlipStock(),
                          );
                        },
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
                          ref.read(cartLProvider.notifier).inQuan(widget.index);
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
                        onSubmitted: (value) {
                          ref
                              .read(cartLProvider.notifier)
                              .setQuan(widget.index, int.parse(value));
                        },
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
                        onPressed: () => ref
                            .read(cartLProvider.notifier)
                            .deQuan(widget.index),
                        icon: const Icon(
                          Icons.remove_circle_outlined,
                          color: Colors.green,
                        )),
                  ],
                ),
                Text(
                  cart.drug.unit,
                  style: const TextStyle(fontSize: 13, letterSpacing: 1),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  'Total: ${ref.watch(cartLProvider).elementAt(widget.index).price.toStringAsFixed(3)}',
                  style: const TextStyle(fontSize: 15, letterSpacing: 1),
                ),
              ],
            ),
            const Divider()
          ],
        ));
  }
}
