import 'package:flutter/material.dart';
import 'package:hci_customer/icons/my_flutter_app_icons.dart';

class FlipStock extends StatefulWidget {
  const FlipStock({Key? key}) : super(key: key);

  @override
  State<FlipStock> createState() => _FlipStockState();
}

class _FlipStockState extends State<FlipStock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: const Icon(
          MyFlutterApp.capsules,
          color: Colors.green,
        ));
  }
}
