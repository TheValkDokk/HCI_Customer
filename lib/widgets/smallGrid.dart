import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../models/drugs.dart';
import '../screens/detail/product_tile.dart';

class buildSmallGrid extends StatelessWidget {
  const buildSmallGrid(this.isPhone, this.list);
  final bool isPhone;
  final List<Drug> list;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int count = isPhone ? 2 : (size.width / 200).ceil();
    return AnimationLimiter(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          mainAxisExtent: 250,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: list.length > 4 ? 4 : list.length,
        itemBuilder: (context, i) {
          return AnimationConfiguration.staggeredGrid(
            position: i,
            columnCount: count,
            duration: const Duration(milliseconds: 1000),
            child: ScaleAnimation(
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: DrugTile(list[i]),
              ),
            ),
          );
        },
      ),
    );
  }
}
