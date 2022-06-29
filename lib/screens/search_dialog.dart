import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_customer/screens/Home/home.dart';
import 'package:searchfield/searchfield.dart';

import '../models/drugs.dart';
import 'detail/info.dart';

class SearchDialog extends ConsumerStatefulWidget {
  const SearchDialog({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Drug> list;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchDialogState();
}

class SearchDialogState extends ConsumerState<SearchDialog> {
  var searchController = TextEditingController();
  List<Drug> searchedList = [];
  List<Drug> listDrug = [];

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
    listDrug = ref.watch(listDrugDataProvider);
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
                                child: Image.network(
                                  searchedList[index].imgUrl,
                                  cacheHeight: 500,
                                ),
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
