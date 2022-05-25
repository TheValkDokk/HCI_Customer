// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'drugs.dart';

class Cart {
  Drug drug;
  int quantity;
  double price;
  Cart({
    required this.drug,
    required this.quantity,
    required this.price,
  });

  @override
  String toString() => 'Cart(drug: $drug, quantity: $quantity, price: $price)';

  Cart copyWith({
    Drug? drug,
    int? quantity,
    double? price,
  }) {
    return Cart(
      drug: drug ?? this.drug,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

class CartListNotifier extends StateNotifier<List<Cart>> {
  CartListNotifier() : super([]);

  void add(Cart cart) {
    state = [...state, cart];
  }

  void addAt(Cart cart, int i) {
    var f = state;
    f.insert(i, cart);
    state = [...f];
  }

  void calcPrice(int i) {
    final tempCart = state[i];
    tempCart.price = tempCart.quantity * tempCart.drug.price;
    remove(state[i]);
    addAt(tempCart, i);
  }

  void inQuan(int i) {
    final tempCart = state[i];
    tempCart.quantity++;
    calcPrice(i);
  }

  void remove(Cart cart) {
    state = [
      for (final e in state)
        if (e != cart) e,
    ];
  }

  void deQuan(int i) {
    final tempCart = state[i];
    tempCart.quantity--;

    remove(state[i]);
    if (tempCart.quantity > 0) {
      addAt(tempCart, i);
      calcPrice(i);
    }
  }

  void setQuan(int i, int quan) {
    if (quan <= 0) {
      remove(state[i]);
    } else {
      final tempCart = state[i];
      tempCart.quantity == quan;
      remove(state[i]);
      addAt(tempCart, i);
      calcPrice(i);
    }
  }

  void delete(int i) {
    if (state[i].quantity <= 0) remove(state[i]);
  }

  void checkQuan(int i) {}
}

final cartLProvider =
    StateNotifierProvider<CartListNotifier, List<Cart>>((ref) {
  return CartListNotifier();
});
