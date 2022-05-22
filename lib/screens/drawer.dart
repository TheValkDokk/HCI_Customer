// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MenuItemDra {
  final String title;
  final IconData icon;
  const MenuItemDra(
    this.title,
    this.icon,
  );
}

class MenuItems {
  static const home = MenuItemDra('Home', Icons.home);
  static const about = MenuItemDra('About Us', Icons.info_outline_rounded);

  static const all = <MenuItemDra>[home, about];
}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({required this.currentItem, required this.onSelectedItem});

  final currentItem;
  final ValueChanged<MenuItemDra> onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.green.shade400,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(
              flex: 2,
            ),
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(MenuItemDra item) => ListTile(
        selected: currentItem == item,
        selectedTileColor: Colors.white,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => onSelectedItem(item),
      );
}
