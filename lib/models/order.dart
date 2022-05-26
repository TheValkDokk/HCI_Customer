// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:hci_customer/models/user.dart';

import 'cart.dart';

class Order {
  PharmacyUser user;
  List<Cart> listCart;
  double price;
  String status;
  Order({
    required this.user,
    required this.listCart,
    required this.price,
    required this.status,
  });

  Order copyWith({
    PharmacyUser? user,
    List<Cart>? listCart,
    double? price,
    String? status,
  }) {
    return Order(
      user: user ?? this.user,
      listCart: listCart ?? this.listCart,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'listCart': listCart.map((x) => x.toMap()).toList(),
      'price': price,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      user: PharmacyUser.fromMap(map['user'] as Map<String, dynamic>),
      listCart: List<Cart>.from(
        (map['listCart'] as List<int>).map<Cart>(
          (x) => Cart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      price: map['price'] as double,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(user: $user, listCart: $listCart, price: $price, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.user == user &&
        listEquals(other.listCart, listCart) &&
        other.price == price &&
        other.status == status;
  }

  @override
  int get hashCode {
    return user.hashCode ^ listCart.hashCode ^ price.hashCode ^ status.hashCode;
  }
}
