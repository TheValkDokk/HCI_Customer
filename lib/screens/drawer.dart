// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/models/cart.dart';
import 'package:hci_customer/screens/home_drawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../main.dart';

class MenuItemDra {
  final String title;
  final IconData icon;
  const MenuItemDra(this.title, this.icon);
}

class MenuItems {
  static const home = MenuItemDra('Home', Icons.home);
  static const about = MenuItemDra('About Us', Icons.info_outline_rounded);

  static const all = <MenuItemDra>[home, about];
}

class DrawerScreen extends ConsumerWidget {
  const DrawerScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  final MenuItemDra currentItem;
  final ValueChanged<MenuItemDra> onSelectedItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(UserProvider).currentUser;
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
                      user!.photoURL ??
                          'https://media.giphy.com/media/Q5Ra0QQUpPYdlFmFrj/giphy.gif'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Center(child: Consumer(
                builder: (context, ref, child) {
                  return Text(
                    user.displayName.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 25),
                  );
                },
              )),
            ),
            const Spacer(flex: 1),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Consumer(
                builder: (context, ref, child) {
                  return ListTile(
                    onTap: () async {
                      if (!kIsWeb) {
                        ref.watch(googleSignInProvider).signOut();
                      }
                      await FirebaseAuth.instance.signOut();
                      ref.invalidate(cartLProvider);
                      ref.invalidate(googleSignInProvider);
                      navKey.currentState!.popUntil((route) => route.isFirst);
                    },
                    minLeadingWidth: 20,
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                  );
                },
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
