import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hci_customer/screens/drawer.dart';
import 'package:searchfield/searchfield.dart';
import '../models/category.dart';
import '../models/drugs.dart';
import '../widgets/flip_stock.dart';
import '../widgets/smallGrid.dart';
import 'cart_screen.dart';
import 'info.dart';
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
  bool isTop = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPhone = size.shortestSide < 650 ? true : false;

    var listA1 = listDrug.where((e) => e.type == 'A1').toList();
    var listA2 = listDrug.where((e) => e.type == 'A2').toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSearchDialog(size),
        backgroundColor: Colors.green,
        child: const Icon(Icons.search),
      ),
      appBar: _HomeAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
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
        return _searchDia(list: list);
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
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ),
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

class _searchDia extends StatefulWidget {
  const _searchDia({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Drug> list;

  @override
  State<_searchDia> createState() => _searchDiaState();
}

class _searchDiaState extends State<_searchDia> {
  var searchController = TextEditingController();
  List<Drug> searchedList = [];

  List<Drug> filterList(String val) {
    val = val.replaceAll('thuốc', '');
    if (searchController.text == '') {
      return listDrug;
    } else {
      return listDrug
          .where((element) =>
              element.fullName.contains(val) || element.title.contains(val))
          .toList();
    }
  }

  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    myFocusNode.requestFocus();
    searchController.addListener(() {
      setState(() {
        searchedList = filterList(searchController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: size.height * 0.7,
        width: size.width * 0.85,
        child: Material(
          child: Center(
            child: Container(
              height: size.height * 0.6,
              width: size.width * 0.85,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  const Text(
                    "Medicine Search",
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SearchField(
                      hint: 'Search',
                      focusNode: myFocusNode,
                      hasOverlay: false,
                      suggestions: widget.list
                          .map(
                            (e) => SearchFieldListItem(e.fullName),
                          )
                          .toList(),
                      maxSuggestionsInViewPort: 3,
                      controller: searchController,
                      searchStyle: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      searchInputDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchedList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        InfoScreen(searchedList[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: SizedBox(
                                height: 100,
                                width: 100,
                                child:
                                    Image.network(searchedList[index].imgUrl),
                              ),
                              title: Text(searchedList[index].title),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
