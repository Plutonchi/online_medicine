// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:online_medicine/app/theme/theme.dart';
import '../screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectIndex = 0;
  final _pageList = [
    const HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];
  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
        selectedItemColor: greenColor,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
