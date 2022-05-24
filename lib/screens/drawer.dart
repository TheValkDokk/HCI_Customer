// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../drawer/my_flutter_app_icons.dart';

class MenuItemDra {
  final String title;
  final IconData icon;
  const MenuItemDra(this.title, this.icon);
}

class MenuItems {
  static const home = MenuItemDra('Home', Icons.home);
  static const about = MenuItemDra('About Us', Icons.info_outline_rounded);
  static const drug = MenuItemDra('Unprescribed Drug', MyFlutterApp.pills);
  static const equipment =
      MenuItemDra('Medical Equipments', MyFlutterApp.pump_medical);
  static const drugs = MenuItemDra('Unprescribed Drug', MyFlutterApp.pills);

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
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CircleAvatar(
                radius: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: Image.network(
                      fit: BoxFit.fill,
                      width: 500,
                      height: 500,
                      'https://media.giphy.com/media/Q5Ra0QQUpPYdlFmFrj/giphy.gif'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Someone\'s Name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            const Spacer(flex: 1),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ListTile(
                onTap: () {},
                minLeadingWidth: 20,
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
              ),
            )
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
