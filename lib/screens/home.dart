import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hci_customer/screens/drawer.dart';
import '../models/category.dart';
import '../models/drugs.dart';
import '../widgets/btnDrug.dart';
import '../widgets/home_appbar.dart';
import '../widgets/smallGrid.dart';
import 'load_more.dart';
import 'search_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._drawerController, this.onSelectedItem);

  final ZoomDrawerController _drawerController;
  final ValueChanged<MenuItemDra> onSelectedItem;

  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTop = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPhone = size.shortestSide < 650 ? true : false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSearchDialog(size),
        backgroundColor: Colors.green,
        child: const Icon(Icons.search),
      ),
      appBar: HomeAppBar(widget._drawerController),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _WidgetBtnGroup(isPhone, context),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _HomeBody(context, isPhone, size),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSearchDialog(Size size) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        var list = listDrug;
        return SearchDialog(list: list);
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  Column _HomeBody(BuildContext context, bool isPhone, Size size) {
    var listA1 = listDrug.where((e) => e.type == 'A1').toList();
    var listA2 = listDrug.where((e) => e.type == 'A2').toList();

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

  GestureDetector _toLoadMoreScreen(
      BuildContext context, List<Drug> list, String title) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadMoreScreen(title: title, list: list),
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
        children: [...iconList.map((e) => ButtonDrug(e)).toList()],
      ),
    );
  }
}
