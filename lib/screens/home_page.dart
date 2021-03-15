import 'package:ecommerce/screens/bottom_tabs.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/tabs/home_tab.dart';
import 'package:ecommerce/tabs/saved_tab.dart';
import 'package:ecommerce/tabs/search_tab.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ]),
        ),
        bottomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabsPageController.animateToPage(num,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic);
          },
        ),
      ],
    ));
  }
}
