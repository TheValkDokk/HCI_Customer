import 'package:flutter/material.dart';

import '../models/drugs.dart';
import 'product_tile.dart';

class buildSmallGrid extends StatelessWidget {
  const buildSmallGrid(this.isPhone, this.list);
  final bool isPhone;
  final List<Drug> list;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isPhone ? 2 : (size.width / 200).ceil(),
        mainAxisExtent: 250,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: list.length > 4 ? 4 : list.length,
      itemBuilder: (context, i) => DrugTile(list[i]),
    );
  }
}
