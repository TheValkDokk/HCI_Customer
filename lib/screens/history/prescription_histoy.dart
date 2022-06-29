import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci_customer/provider/global.dart';
import 'package:hci_customer/models/prescription.dart';

import 'components/prescription_history_tile.dart';

class PresciptionHistoryScree extends StatefulWidget {
  const PresciptionHistoryScree({Key? key}) : super(key: key);

  @override
  State<PresciptionHistoryScree> createState() =>
      _PresciptionHistoryScreeState();
}

class _PresciptionHistoryScreeState extends State<PresciptionHistoryScree> {
  final List<Prescription> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription History'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
          icon: const Icon(Icons.menu_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getList(),
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (list.isEmpty) {
              return const Center(
                  child: Text('You don\'t have any Drug Presription'));
            } else {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  ...list.map((e) => PresciptionHistoryTile(e)).toList()
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future getList() async {
    final preS = db.collection('prescription');
    await preS
        .where('mail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      for (var e in value.docs) {
        list.add(Prescription.fromMap(e.data()));
      }
    });
    return list;
  }
}
