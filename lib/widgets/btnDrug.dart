import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/drugs.dart';
import '../screens/load_more.dart';
import 'flip_stock.dart';

class ButtonDrug extends StatelessWidget {
  const ButtonDrug(this.cat);

  final Category cat;

  List<Drug> getType(String type) {
    return listDrug.where((e) => e.type == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadMoreScreen(
            title: cat.title,
            list: getType(cat.type),
          ),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.17,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: cat.url,
                  placeholder: (context, url) => const FlipStock(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              cat.title,
              maxLines: 2,
              style: const TextStyle(wordSpacing: 1, fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }
}
