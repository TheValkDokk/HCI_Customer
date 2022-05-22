import 'package:flutter/material.dart';

import '../models/drugs.dart';
import '../widgets/product_tile.dart';
import 'cart_screen.dart';
import 'load_more.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool isPhone = size.shortestSide < 650 ? true : false;

    //Unprescripted drugs
    var listA1 = listDrug.where((e) => e.type == 'A1').toList();
    //Medical Devices/Equipments
    var listA2 = listDrug.where((e) => e.type == 'A2').toList();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Pharmacy"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: isPhone ? 10 : 30,
                children: [
                  btnDrug(context, Icons.ad_units),
                  btnDrug(context, Icons.access_alarm),
                  btnDrug(context, Icons.account_balance_outlined),
                  btnDrug(context, Icons.yard_rounded),
                  btnDrug(context, Icons.wordpress),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  GestureDetector(
                    //Load More Drug by Type
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadMoreScreen(
                          title: 'Unprescribed Drugs',
                          list: listA1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Unprescribed Drugs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Unprescription drugs section
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPhone ? 2 : (size.width / 200).ceil(),
                      mainAxisExtent: 250,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: listA1.length > 4 ? 4 : listA1.length,
                    itemBuilder: (context, i) => DrugTile(
                      listA1[i],
                    ),
                  ),
                  GestureDetector(
                    //Load More Drug by Type
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadMoreScreen(
                          title: 'Medical Devices',
                          list: listA2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Medical Devices/Equipments",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Medical Device section
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPhone ? 2 : (size.width / 200).ceil(),
                      mainAxisExtent: 250,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: isPhone
                        ? listA2.length > 4
                            ? 4
                            : listA2.length
                        : listA2.length,
                    itemBuilder: (context, i) => DrugTile(
                      listA2[i],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget btnDrug(BuildContext ctx, var icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.lightGreen),
                boxShadow: const [BoxShadow(color: Colors.white)]),
            child: Icon(
              icon,
              color: Colors.green,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
