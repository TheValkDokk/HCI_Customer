import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/drugs.dart';

class DialogSearch extends ConsumerStatefulWidget {
  const DialogSearch({Key? key}) : super(key: key);

  @override
  ConsumerState<DialogSearch> createState() => _DialogSearchState();
}

class _DialogSearchState extends ConsumerState<DialogSearch> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var list = listDrug;
    return Container();
  }
}
