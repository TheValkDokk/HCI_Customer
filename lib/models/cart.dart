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
}

List<Cart> cartList = [];
