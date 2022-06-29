import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/screens/Home/home.dart';
import 'package:hci_customer/screens/prescription/presciption_screen.dart';

import '../models/category.dart';
import '../models/drugs.dart';
import '../screens/detail/load_more.dart';

class ButtonDrug extends ConsumerWidget {
  const ButtonDrug(this.cat);

  final Category cat;

  List<Drug> getType(String type, WidgetRef ref) {
    return ref
        .watch(listDrugDataProvider)
        .where((e) => e.type == type)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          if (cat.type == 'camera') {
            return const PrescriptionScreen();
          } else {
            return LoadMoreScreen(
                title: cat.title, list: getType(cat.type, ref));
          }
        }),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5)),
          leading: SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              child: Icon(cat.url, color: Colors.green),
            ),
          ),
          title: Text(
            textAlign: TextAlign.center,
            cat.title,
            maxLines: 2,
            style: const TextStyle(wordSpacing: 1, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
