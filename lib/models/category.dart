import 'package:flutter/widgets.dart';

import '../icons/my_flutter_app_icons.dart';

class Category {
  final String title;
  final IconData url;
  final String type;

  Category(this.title, this.url, this.type);
}

List<Category> iconList = [
  Category('Unprescribed Drugs', MyFlutterApp.capsules, 'A1'),
  Category('Medical Equipment', MyFlutterApp.briefcase_medical, 'A2'),
  Category('Prescription Picture', MyFlutterApp.prescription_bottle, 'camera'),
  Category('Nearby Pharmacy', MyFlutterApp.clinic_medical, 'A4'),
];
