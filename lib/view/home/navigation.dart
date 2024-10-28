import 'package:flutter/material.dart';
import 'package:checklist_app/widget_style/widget_color.dart';
import 'package:checklist_app/view/home/home.dart';
import 'package:checklist_app/view/home/wishlist.dart';


class NavBar extends StatefulWidget {
  // final TaskController controller;
  //
  // NavBar({required this.controller});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    WishlistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetColor myColor = WidgetColor();
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          backgroundColor: myColor.mainBackground,

        items: [
          //home
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png", width: 25),
            label: 'Home',
          ),
          // wishlist
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/save1.png", width: 25),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
