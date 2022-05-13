import 'package:flutter/material.dart';
import 'package:my_website/page/home.dart';

import '../globals_variable.dart';

import 'page/covid.dart';
import 'page/crud.dart';
import 'page/game.dart';

class PageCtrl extends StatefulWidget {
  const PageCtrl({Key? key}) : super(key: key);
  final String title = 'Home';

  @override
  State<PageCtrl> createState() => _PageCtrlState();
}

class _PageCtrlState extends State<PageCtrl> {
  late List<Widget> pages;
  late List<String> titleOfPage;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomePage(),
      const Covid(),
      const CRUD(),
      const Game(),
    ];

    titleOfPage = [
      const HomePage().title,
      const Covid().title,
      const CRUD().title,
      const Game().title,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: _drawer(),
        appBar: AppBar(
          leading: MediaQuery.of(context).size.width <= 485
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                )
              : null,
          title: Text(titleOfPage[currentPage]),
        ),
        body: pages[currentPage]);
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          _buttonInDrawer(Icons.home, 'Home', 0),
          _buttonInDrawer(Icons.local_hospital, 'Check Covid-19', 1),
          _buttonInDrawer(Icons.create, 'CRUD', 2),
          _buttonInDrawer(Icons.games, 'Game', 3),
        ],
      ),
    );
  }

  Widget _buttonInDrawer(IconData ic, String txt, int x) {
    return ListTile(
        leading: Icon(ic),
        title: Text(txt),
        onTap: () {
          setState(() {
            currentPage = x;
          });
        });
  }
}// end class