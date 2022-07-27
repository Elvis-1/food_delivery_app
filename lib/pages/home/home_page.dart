import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;

  List page = [
    MainFoodPage(),
    Container(
      child: Center(
        child: Text("Page"),
      ),
    ),
    Container(
      child: Center(
        child: Text("Next Page"),
      ),
    ),
    Container(
      child: Center(
        child: Text("Next Next Page"),
      ),
    ),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              title: Text('Home'), icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              title: Text('Home'), icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              title: Text('Home'), icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              title: Text('Home'), icon: Icon(Icons.home_outlined)),
        ],
      ),
    );
  }
}
