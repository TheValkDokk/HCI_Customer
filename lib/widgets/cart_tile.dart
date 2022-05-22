import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../screens/info.dart';

class CartTile extends StatefulWidget {
  const CartTile(this._cart);

  final Cart _cart;

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
    countController.text = widget._cart.quantity.toString();
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => InfoScreen(widget._cart.drug)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Hero(
                    tag: widget._cart.drug.id,
                    child: Image.network(
                      height: size.height * 0.1,
                      width: size.width * 0.4,
                      widget._cart.drug.imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    widget._cart.drug.fullName,
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
                      text: " ${widget._cart.drug.rating}",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget._cart.quantity++;
                          widget._cart.price =
                              widget._cart.quantity * widget._cart.drug.price;
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
                        widget._cart.quantity = int.parse(value);
                        widget._cart.price =
                            widget._cart.quantity * widget._cart.drug.price;
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
                        setState(() {
                          widget._cart.quantity--;
                          widget._cart.price =
                              widget._cart.quantity * widget._cart.drug.price;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle_outlined,
                        color: Colors.green,
                      )),
                ],
              ),
              Text(
                'Total: ${widget._cart.price.toStringAsFixed(3)}',
                style: const TextStyle(fontSize: 15, letterSpacing: 1),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
