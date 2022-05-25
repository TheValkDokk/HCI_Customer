import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hci_customer/screens/drawer.dart';
import '../models/category.dart';
import '../models/drugs.dart';
import '../widgets/flip_stock.dart';
import '../widgets/smallGrid.dart';
import 'cart_screen.dart';
import 'load_more.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._drawerController, this.onSelectedItem);

  final ZoomDrawerController _drawerController;
  final ValueChanged<MenuItemDra> onSelectedItem;

  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPhone = size.shortestSide < 650 ? true : false;

    var listA1 = listDrug.where((e) => e.type == 'A1').toList();
    var listA2 = listDrug.where((e) => e.type == 'A2').toList();

    return Scaffold(
      appBar: _HomeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _WidgetBtnGroup(isPhone, context),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _HomeBody(context, listA1, isPhone, size, listA2),
            )
          ],
        ),
      ),
    );
  }

  Column _HomeBody(BuildContext context, List<Drug> listA1, bool isPhone,
      Size size, List<Drug> listA2) {
    return Column(
      children: [
        _toLoadMoreScreen(context, listA1, 'Unprescribed Drugs'),
        const SizedBox(height: 10),
        buildSmallGrid(isPhone, listA1),
        _toLoadMoreScreen(context, listA2, "Medical Devices/Equipments"),
        const SizedBox(height: 10),
        buildSmallGrid(isPhone, listA2),
      ],
    );
  }

  AppBar _HomeAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => widget._drawerController.toggle!(),
        icon: const Icon(Icons.menu_rounded),
      ),
      title: const Text("Pharmacy"),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        )
      ],
    );
  }

  GestureDetector _toLoadMoreScreen(
      BuildContext context, List<Drug> list, String title) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadMoreScreen(
            title: title,
            list: list,
            drawerController: widget._drawerController,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }

  Padding _WidgetBtnGroup(bool isPhone, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isPhone ? 10 : MediaQuery.of(context).size.width * 0.02,
        // spacing: MediaQuery.of(context).size.width * 0.02,
        children: [...iconList.map((e) => btnDrug(context, e)).toList()],
      ),
    );
  }

  List<Drug> getType(String type) {
    return listDrug.where((e) => e.type == type).toList();
  }

  Widget btnDrug(BuildContext ctx, Category cat) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadMoreScreen(
            title: cat.title,
            list: getType(cat.type),
            drawerController: widget._drawerController,
          ),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.17,
        child: Flexible(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  child: Image.network(
                    cat.url,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: FlipStock(),
                      );
                    },
                  ),
                  // child: CachedNetworkImage(
                  //   imageUrl: cat.url,
                  //   placeholder: (context, url) => const FlipStock(),
                  //   errorWidget: (context, url, error) =>
                  //       const Icon(Icons.error),
                  // ),
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
      ),
    );
  }
}
